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


%% Remove stations that are very close to eachother
function [file_list_update] = mod_remove_duplicates(file_list,settings)
% Create a list with lat/lon pairs and station length
lon = zeros(numel(file_list),1);
lat = zeros(numel(file_list),1);
num_obs = zeros(numel(file_list),1);
for i=1:numel(file_list)
   read_file = strcat(settings.stat_dir,file_list(i).name);
   load(read_file);
   lon(i) = station_data.lon;
   lat(i) = station_data.lat;
   num_obs(i) = numel(station_data.time);
end

% Create array with distances
radius = 6371;
latdist = zeros(numel(file_list))*nan;
londist = zeros(numel(file_list))*nan;
distmat = zeros(numel(file_list))*nan;

for i=1:numel(file_list)
    for j=1:numel(file_list)
        if i~=j
            latdist(i,j) = abs(lat(i) - lat(j));
            londist(i,j) = abs(lon(i) - lon(j));
            distmat(i,j) = 2.*radius.*asin(sqrt(sind(0.5.*(lat(i)-lat(j))).^2+cosd(lat(j)).*cosd(lat(i)).*sind(0.5.*(lon(i)-lon(j))).^2));
        end
    end
end

% Check which stations are on the same location
[lat_i,lat_j] = find(distmat<3);
checked_stations = unique(sort([lat_i;lat_j]));

% For all stations that are on same location select station with most observations
acc_station = zeros(numel(checked_stations),1)*false;
for i=1:numel(checked_stations)
    idx = checked_stations(i);
    idx_lcl = find(distmat(idx,:)<3);
    if num_obs(idx) > max(num_obs(idx_lcl))
        acc_station(i) = true;
    end
end

% Remove non-accepted stations
file_list_update = file_list;
file_list_update(checked_stations(~acc_station)) = [];
