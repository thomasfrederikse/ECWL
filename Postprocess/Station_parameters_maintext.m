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

%% For each station save location, shape, scale, and 100-yr return height above msl
clear all; close all; clc;
addpath(genpath('~/Scripts/matlab/'));

GMT_dir = '~/Scripts/GMT/Papers/global_extremes/Maintext/esl_params/';
extremes_dir = '~/Data/Extremes/Paper/esl_scenarios/';
filename_settings = strcat(extremes_dir,'settings.mat');
load(filename_settings)

filename = strcat(settings.extremes_dir,'RCP26_2100_0.mat');
load(filename);
latlon_array = zeros(numel(result_array),2);
for i=1:numel(result_array)
    latlon_array(i,1)=result_array(i).lon;
    latlon_array(i,2)=result_array(i).lat;
end

loc_array   = zeros(numel(result_array),1);
shape_array = zeros(numel(result_array),1);
scale_array = zeros(numel(result_array),1);
rp100_array = zeros(numel(result_array),1);
rp100_spread_array = zeros(numel(result_array),1);
idx = find(settings.gpd_return_period==100);

for i=1:numel(result_array)
    loc_array(i) = result_array(i).gpd.loc;
    shape_array(i) = result_array(i).gpd.shape;
    scale_array(i) = result_array(i).gpd.scale;
    rp100_array(i) = result_array(i).pd.rc_mean(idx);
    rp100_spread_array(i) = result_array(i).pd.rc_pct(idx,3)-result_array(i).pd.rc_pct(idx,1);
end
dlmwrite(strcat(GMT_dir,'loc.txt'),[latlon_array,loc_array], 'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'scale.txt'),[latlon_array,scale_array], 'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'shape.txt'),[latlon_array,shape_array], 'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'rp100.txt'),[latlon_array,rp100_array], 'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'rp100_spread.txt'),[latlon_array,rp100_spread_array], 'delimiter',' ','precision','%.3f');

% Determine station length (unique years)
file_list = dir(strcat(settings.stat_dir,'stat*'));
file_list = mod_remove_duplicates(file_list,settings);

unique_years = zeros(numel(file_list),1);
for stat=1:numel(file_list)
    disp(stat)
    load_data = load(strcat(settings.stat_dir,file_list(stat).name),'station_data');
    stattime = datevec(load_data.station_data.time);
    unique_years(stat) = numel(unique(stattime(:,1)));
end
dlmwrite(strcat(GMT_dir,'num_years.txt'),[latlon_array,unique_years], 'delimiter',' ','precision','%.3f');



