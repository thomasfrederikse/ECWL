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

%% Compute extreme-value statistics and changes under MSL changes for tide-gauge stations

% Read and pre-process GESLA data
clear all; close all; clc;
addpath(genpath('~/Scripts/Extremes/mod/'));

settings.stat_dir     = '~/Data/Extremes/Station_data_matlab/';
settings.scenario_dir = '~/Data/Extremes/Paper/msl_scenarios/';
settings.extremes_dir = '~/Data/Extremes/Paper/esl_scenarios/';
settings.allowance_range = (-0.5:0.01:8)';
settings.amp_factor_year = 100;
settings.allowance_year = 100;
settings.fix_threshold = true;
settings.fix_threshold_val = 99.7;
settings.threshold_range = (99:0.05:99.9)';
settings.pval = 0.10;
settings.num_mc = 10000;
settings.gpd_return_period = 10.^(-1:0.025:3)';
settings.yearlist = [2050;2100];
settings.rcplist = [26;45;85];

%% List of GESLA files and remove duplicate stations
file_list = dir(strcat(settings.stat_dir,'stat*'));
file_list = mod_remove_duplicates(file_list,settings);

%% Initialize station array and determine threshold
station_array = mod_determine_threshold(file_list,settings);

%% Compute esl results
for yr=1:numel(settings.yearlist)
    settings.year = settings.yearlist(yr);
    for rcp=1:numel(settings.rcplist)
        settings.rcp = settings.rcplist(rcp);
        msl_proj = mod_read_msl_ais_proj(settings);
        for scn=1:numel(msl_proj.AIS_ctb)
            fprintf('                    ----------------------\n')
            fprintf('                    Year             %i \n',settings.year)
            fprintf('                    Scenario         %i \n',settings.rcp)
            fprintf('                    AIS contribution %.2f \n',msl_proj.AIS_ctb(scn))
            fprintf('                    ----------------------\n')
            fprintf('\n')

            % Select scenario
            msl_proj_lcl.lat = msl_proj.lat;
            msl_proj_lcl.lon = msl_proj.lon;
            msl_proj_lcl.msl_mean = msl_proj.msl_mean(:,:,scn);
            msl_proj_lcl.msl_ste  = msl_proj.msl_ste(:,:,scn);
            
            % initialize result array
            clear result_array
            result_array = station_array;
            parfor i=1:numel(station_array)
                result_lcl = mod_compute_extremes_stat(msl_proj_lcl,station_array(i),settings);
                % Store in final result array
                result_array(i).slr        = result_lcl.msl;
                result_array(i).gpd        = result_lcl.gpd;
                result_array(i).pd         = result_lcl.pd;
                result_array(i).fut        = result_lcl.fut;
            end
            % Save
            f_save = strcat(settings.extremes_dir,'RCP',num2str(settings.rcp),'_',num2str(settings.year),'_',num2str(msl_proj.AIS_ctb(scn)),'.mat');
            save(f_save,'result_array');
        end
    end
end
filename_settings = strcat(settings.extremes_dir,'settings.mat');
save(filename_settings,'settings')