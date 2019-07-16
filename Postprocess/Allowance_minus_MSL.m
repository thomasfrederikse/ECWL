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

%% Save allowance minus msl change
clear all; close all; clc;
addpath(genpath('~/Scripts/matlab/'));

GMT_dir = '~/Scripts/GMT/Papers/global_extremes/Maintext/msl_all_frac/';
extremes_dir = '~/Data/Extremes/Paper/esl_scenarios/';
filename_settings = strcat(extremes_dir,'settings.mat');
load(filename_settings)

filename = strcat(extremes_dir,'RCP26_2100_0.mat');
load(filename);
loc_array = zeros(numel(result_array),2);
for i=1:numel(result_array)
    loc_array(i,1)=result_array(i).lon;
    loc_array(i,2)=result_array(i).lat;
end


scn_rcp  = {'26','85','26','85'};
scn_ant  = {'0','0','0','0'};
scn_year = {'2050','2050','2100','2100'};

idx = find(settings.gpd_return_period==100);
for scn=1:numel(scn_ant)
    loadfile = strcat(extremes_dir,'RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.mat');
    load(loadfile)
    slr_all_frac = zeros(numel(result_array),1);
    for i=1:numel(result_array)
        slr_all_frac(i) = result_array(i).fut.allowance - result_array(i).slr.mean;
    end
    slr_all_frac(slr_all_frac<0) = 0;
    dlmwrite(strcat(GMT_dir,'frac_RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.txt'),[loc_array,100*slr_all_frac], 'delimiter',' ','precision','%.3f');
end




