function mod_read_gesla_station(read_file,write_file,settings)

% Step 1: read raw data
fprintf('Reading data... ')

fileID = fopen(read_file);
raw_data = textscan(fileID,'%s %s %f %f %f','HeaderLines',32);
fclose(fileID);

% Remove non-accepted indices
flag = true(numel(raw_data{1}),1);
flag(raw_data{4}~=1)   = false;
flag(raw_data{3}<-9.9) = false;

height_raw = raw_data{3}(flag);
time_raw   = datenum(strcat(raw_data{1}(flag),';',raw_data{2}(flag)),'yyyy/mm/dd;HH:MM:SS');
time_vec   = datevec(time_raw);
fprintf('done\n')
fprintf('Convert to hourly data... ')

% Average to hourly values
time_vec(:,5:6) = 0;
time_hr = datenum(time_vec);
[station_data.time,b,~]   = unique(time_hr);
station_data.height = zeros(numel(station_data.time),1);
out = [b,histc(time_hr,station_data.time)];

for i = 1:numel(station_data.height)
    station_data.height(i) = mean(height_raw(out(i,1):out(i,1)+out(i,2)-1));
end
fprintf('done\n')

% Remove annual means and throw away too short years
fprintf('Remove annual means... ')
annual_acc  = true(numel(station_data.time),1);
annual_vec = datevec(station_data.time);
unique_years = unique(annual_vec(:,1));
n=0;
for i=1:numel(unique_years)
   year_idx = annual_vec(:,1)==unique_years(i);
   if sum(year_idx) < settings.daily_obs_per_year*24
       annual_acc(year_idx) = false;
   else
       station_data.height(year_idx) = station_data.height(year_idx) - mean(station_data.height(year_idx));
       n=n+1;
   end
end
station_data.nyears = n;
station_data.time   = station_data.time(annual_acc);
station_data.height = station_data.height(annual_acc);
fprintf('done\n')

if n>=settings.min_years
    fprintf('Computing extremes... ')
    % Determine extremes
    POT_threshold = prctile(station_data.height,95);
    extreme_obs   = station_data.height(station_data.height>POT_threshold);
    extreme_time  = station_data.time(station_data.height>POT_threshold);
    [extreme_obs,idx] = sort(extreme_obs,'descend');
    extreme_time = extreme_time(idx);

    % Determine POT values
    POT_range = (95:0.05:99.9)';
    station_data.POT_values = zeros(numel(POT_range),2);
    station_data.POT_values(:,1) = POT_range;
    for i=1:numel(POT_range)
        station_data.POT_values(i,2) = prctile(station_data.height,POT_range(i));
    end
    fprintf('done\n')

    fprintf('Declustering... ')
    % Decluster events
    extreme_acc = true(numel(extreme_obs),1);
    for i=2:numel(extreme_time)
        idx = false(numel(extreme_time),1);
        idx(1:i-1) = true;
        idx = and(idx,extreme_acc);
        if min(abs(extreme_time(idx) - extreme_time(i))) < 3
            extreme_acc(i) = false;
        end
    end
    station_data.POT95_time   = extreme_time(extreme_acc);
    station_data.POT95_height = extreme_obs(extreme_acc);
    fprintf('done\n')

    fprintf('Computing return periods... ')
    % Determine return periods
    station_data.POT95_return_period = zeros(numel(station_data.POT95_time),2);
    station_data.POT95_return_period(:,1) = (1 + numel(station_data.time)/365.25/24)./(1:numel(station_data.POT95_time))';
    station_data.POT95_return_period(:,2) = station_data.POT95_height;
    fprintf('done\n')

    fprintf('Reading metadata... ')
    % Station name lat lon
    fileID = fopen(read_file);
    numLines = 6;
    header_info = cell(numLines,1);
    for i = 1:numLines
        header_info(i) = {fgetl(fileID)}; 
    end
    fclose(fileID);
    station_data.name = strtrim(header_info{2}(12:end));
    station_data.lat = str2double(strtrim(header_info{5}(12:end)));
    station_data.lon = str2double(strtrim(header_info{6}(12:end)));
     
    fprintf('done\n')

    % Save
    fprintf('Saving... ')
    save(write_file,'station_data')
    fprintf('done\n')
else
    fprintf('Station too short... ')
    fprintf('done\n')
end
end

