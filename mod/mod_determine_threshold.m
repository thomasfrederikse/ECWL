% ---------------------------------------------------------------------
% Copyright (C) 2018-2019 Thomas Frederikse
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>
% ---------------------------------------------------------------------

function [station_array] = mod_determine_threshold(file_list,settings)
station_array(1:numel(file_list)) = struct('lon',[]);

for stat=1:numel(file_list)
    load_data = load(strcat(settings.stat_dir,file_list(stat).name),'station_data');
    station_data = load_data.station_data;
    station_array(stat).lon        = station_data.lon;
    station_array(stat).lat        = station_data.lat;
    station_array(stat).name       = station_data.name;
    % Set station country
    if strcmp(station_data.country,'Unspecified')
        if strcmp(station_array(stat).name,'Bermuda')
            station_array(stat).country = "United States of America";
        else
            name_str = strsplit(station_data.name,',');
            station_array(stat).country = strtrim(name_str{end});     
        end
    elseif strcmp(station_data.country,'United States')
        station_array(stat).country = "United States of America";
    elseif strcmp(station_data.country,'USA')
        station_array(stat).country = "United States of America";
    else
        station_array(stat).country = station_data.country;
    end
    station_array(stat).filename   = strcat(file_list(stat).folder,'/',file_list(stat).name);
    if (settings.fix_threshold==false)
        p_list = zeros(numel(settings.threshold_range),1);
        shape_list = zeros(numel(settings.threshold_range),1);
        scale_list = zeros(numel(settings.threshold_range),1);
        loc_list = zeros(numel(settings.threshold_range),1);
        exceed_list = zeros(numel(settings.threshold_range),1);
        for i=1:numel(settings.threshold_range)
            loc_list(i) = station_data.POT_values(abs(station_data.POT_values(:,1)-settings.threshold_range(i))<1e-8,2);
            extr_height = station_data.POT95_height(station_data.POT95_height>loc_list(i));
            exceed_list(i)  = 365.25*24*numel(extr_height)./numel(station_data.height); % Average exceedances per  year for threshold
            
            %% Fit distribution and covariance matrix
            gpd_mean       = gpfit(extr_height-loc_list(i));
            shape = gpd_mean(1);
            scale = gpd_mean(2);
            dist = makedist('GeneralizedPareto','k',shape,'sigma',scale,'theta',0);
            [~,pval]  = adtest(extr_height-loc_list(i),'Distribution',dist);
            p_list(i) = pval;
            shape_list(i) = shape;
            scale_list(i) = scale;
        end
        % Diagnostics
        
        ForwardStop = -1./(1:(numel(settings.threshold_range)))' .* cumsum(log(1-p_list));
        refuse_idx     = find(p_list < settings.pval,1,'last');
        if isempty(refuse_idx) % All accepted
            station_array(stat).threshold = settings.threshold_range(1);
            acc_idx = 1;
        elseif refuse_idx == numel(settings.threshold_range) % All rejected
            station_array(stat).threshold = NaN;
            acc_idx = NaN;
        else
            station_array(stat).threshold = settings.threshold_range(refuse_idx);
            acc_idx = refuse_idx + 1;
        end
    else
        station_array(stat).threshold = settings.fix_threshold_val;
    end
    
end

% Remove non-accepted indices
station_array = station_array(isfinite([station_array(:).threshold]));


