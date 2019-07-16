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
clear all; close all; clc;

%% Read and pre-process GESLA data 
addpath(genpath('~/Scripts/Extremes/mod/'));

settings.gesla_dir = '~/Data/Extremes/GESLA2/';
settings.stat_dir  = '~/Data/Extremes/Station_data_matlab/';
settings.daily_obs_per_year = 250;
settings.min_years = 20;

%% List of GESLA files
statlist = dir(settings.gesla_dir);
statlist = statlist(4:end);

%% Read all files
parfor i=1:numel(statlist)
   fprintf('Processing station %i... \n',i)
   read_file  = strcat(statlist(i).folder,'/',statlist(i).name);
   write_file = strcat(settings.stat_dir,'stat',sprintf('%04i',i),'.mat');
   mod_read_gesla_station(read_file,write_file,settings);
end