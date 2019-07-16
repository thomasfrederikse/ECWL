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

%% Save the data for selected stations for example plot
clear all; close all; clc;
addpath(genpath('~/Scripts/matlab/'));

GMT_dir = '~/Scripts/GMT/Papers/global_extremes/Maintext/example/';
extremes_dir = '~/Data/Extremes/Paper/esl_scenarios/';
filename_settings = strcat(extremes_dir,'settings.mat');
load(filename_settings)

filename = strcat(settings.extremes_dir,'RCP26_2100_0.mat');
load(filename);
selected_stats = [113,352,356,1009];

stat_idx = zeros(numel(result_array),1);
for i=1:numel(result_array)
    stat_idx(i) = str2double(result_array(i).filename(end-7:end-4));
end

sel_idx = zeros(numel(selected_stats),1);
for i=1:numel(selected_stats)
    sel_idx(i) = find(stat_idx==selected_stats(i));
end

scn_rcp  = {'26','26','85','85','26','26','26','85','85','85'};
scn_ant  = {'0','0.1','0','0.1','0','0.15','0.3','0','0.3','0.6'};
scn_year = {'2050','2050','2050','2050','2100','2100','2100','2100','2100','2100'};
yr=1; % all in 2050

for scn=1:numel(scn_rcp)
    loadfile = strcat(extremes_dir,'RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.mat');
    load(loadfile)
    for stat=1:numel(selected_stats)
        % Save pd observed
        filename_write = strcat(GMT_dir,'rp_pd_obs_',num2str(selected_stats(stat)),'.txt');
        dlmwrite(filename_write,[result_array(sel_idx(stat)).pd.rc_obs(:,1),result_array(sel_idx(stat)).pd.rc_obs(:,2)], 'delimiter',' ','precision','%.3f');
        % Save pd mean
        filename_write = strcat(GMT_dir,'rp_pd_mn_',num2str(selected_stats(stat)),'.txt');
        dlmwrite(filename_write,[settings.gpd_return_period,result_array(sel_idx(stat)).pd.rc_mean], 'delimiter',' ','precision','%.3f');        
        % Save PD sterr
        pd_ste = [settings.gpd_return_period,result_array(sel_idx(stat)).pd.rc_pct(:,1);flipud(settings.gpd_return_period),flipud(result_array(sel_idx(stat)).pd.rc_pct(:,3))];
        filename_write = strcat(GMT_dir,'rp_pd_ste_',num2str(selected_stats(stat)),'.txt');
        dlmwrite(filename_write,pd_ste, 'delimiter',' ','precision','%.3f');  
        % Save best-estimate
        filename_write = strcat(GMT_dir,'rp_',scn_year{scn},'_',scn_rcp{scn},'_',scn_ant{scn},'_rc_best_',num2str(selected_stats(stat)),'.txt');
        dlmwrite(filename_write,[settings.gpd_return_period,result_array(sel_idx(stat)).fut.rc_best], 'delimiter',' ','precision','%.3f');
        % Save MSL
        trend_array = [scn-0.5, result_array(sel_idx(stat)).slr.mean, result_array(sel_idx(stat)).slr.ste];
        filename_write = strcat(GMT_dir,'slr_',scn_year{scn},'_',scn_rcp{scn},'_',scn_ant{scn},'_',num2str(selected_stats(stat)),'.txt');
        dlmwrite(filename_write,trend_array, 'delimiter',' ','precision','%.3f');
    end
end

% Write lat lon for plot
loc_map = zeros(numel(sel_idx),3);
for i=1:numel(sel_idx)
    loc_map(i,1) = result_array(sel_idx(i)).lon;
    loc_map(i,2) = result_array(sel_idx(i)).lat;
    loc_map(i,3) = i;
end
filename_write = strcat(GMT_dir,'stat_locs.txt');
dlmwrite(filename_write,loc_map, 'delimiter',' ');

