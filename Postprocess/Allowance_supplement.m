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

%% Save allowances for RCP scenarios for the SI
clear all; close all; clc;
addpath(genpath('~/Scripts/matlab/'));

GMT_2050 = '~/Scripts/GMT/Papers/global_extremes/Supplement/SI_Al_2050/';
GMT_2100 = '~/Scripts/GMT/Papers/global_extremes/Supplement/SI_Al_2100/';

extremes_dir = '~/Data/Extremes/Paper/esl_scenarios/';
filename_settings = strcat(extremes_dir,'settings.mat');
load(filename_settings)

filename = strcat(settings.extremes_dir,'RCP26_2100_0.mat');
load(filename);
loc_array = zeros(numel(result_array),2);
for i=1:numel(result_array)
    loc_array(i,1)=result_array(i).lon;
    loc_array(i,2)=result_array(i).lat;
end

% 2050
ais  = {'0','0.05','0.1','0.15','0.2','0.3','0.45'};
year = [2050];
scn  = {'26','45','85'};
for s=1:numel(scn)
    for y=1:numel(year)
        for a=1:numel(ais)
            filename = strcat(extremes_dir,'RCP',scn{s},'_',num2str(year(y)),'_',ais{a},'.mat');
            load(filename)
            amp_fac = zeros(numel(result_array),1);
            allowance = zeros(numel(result_array),1);
            for i=1:numel(result_array)
                amp_fac(i) = 100*result_array(i).fut.allowance;
            end
            fname = strcat(GMT_2050,'al_RCP',scn{s},'_',ais{a},'.txt');
            dlmwrite(fname,[loc_array,amp_fac], 'delimiter',' ','precision','%.3f');
        end
    end
end

% 2100
ais  = {'0','0.15','0.3','0.45','0.6','0.9','1.2','1.5'};
year = [2100];
scn  = {'26','45','85'};
for s=1:numel(scn)
    for y=1:numel(year)
        for a=1:numel(ais)
            filename = strcat(extremes_dir,'RCP',scn{s},'_',num2str(year(y)),'_',ais{a},'.mat');
            load(filename)
            amp_fac = zeros(numel(result_array),1);
            allowance = zeros(numel(result_array),1);
            for i=1:numel(result_array)
                amp_fac(i) = 100*result_array(i).fut.allowance;
            end
            fname = strcat(GMT_2100,'al_RCP',scn{s},'_',ais{a},'.txt');
            dlmwrite(fname,[loc_array,amp_fac], 'delimiter',' ','precision','%.3f');
        end
    end
end