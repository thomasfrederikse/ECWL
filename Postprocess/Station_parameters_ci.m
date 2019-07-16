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

%% For each station save shape, scale, 5th, 95th, and 50% pct.
clear all; close all; clc;
addpath(genpath('~/Scripts/matlab/'));

GMT_dir = '~/Scripts/GMT/Papers/global_extremes/Supplement/SI_GPD_CI/';
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

shape_5 = zeros(numel(result_array),1);
shape_50 = zeros(numel(result_array),1);
shape_95 = zeros(numel(result_array),1);
scale_5 = zeros(numel(result_array),1);
scale_50 = zeros(numel(result_array),1);
scale_95 = zeros(numel(result_array),1);

idx = find(settings.gpd_return_period==100);

for i=1:numel(result_array)
    shape_5(i) = result_array(i).gpd.par_pct(1,1);
    shape_50(i) = result_array(i).gpd.par_pct(2,1);
    shape_95(i) = result_array(i).gpd.par_pct(3,1);

    scale_5(i) = result_array(i).gpd.par_pct(1,2);
    scale_50(i) = result_array(i).gpd.par_pct(2,2);
    scale_95(i) = result_array(i).gpd.par_pct(3,2);
end
dlmwrite(strcat(GMT_dir,'shape_5.txt'),[latlon_array,shape_5], 'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'shape_50.txt'),[latlon_array,shape_50], 'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'shape_95.txt'),[latlon_array,shape_95], 'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'scale_5.txt'),[latlon_array,scale_5], 'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'scale_50.txt'),[latlon_array,scale_50], 'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'scale_95.txt'),[latlon_array,scale_95], 'delimiter',' ','precision','%.3f');
