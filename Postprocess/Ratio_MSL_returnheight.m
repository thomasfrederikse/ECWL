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

%% Compute and save the return period corresponding to future MSL

clear all; close all; clc;
addpath(genpath('~/Scripts/matlab/'));

GMT_dir = '~/Scripts/GMT/Papers/global_extremes/Maintext/ratio/';
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

pd_ex_fut_mn = zeros(numel(result_array),1);
for i = 1:numel(result_array)
    acc = find(isfinite(result_array(i).fut.rc_best));
    if result_array(i).slr.mean < result_array(i).fut.rc_best(acc(1))
        pd_ex_fut_mn(i) = 0;
    else
        [~,idx] = nanmin(abs(result_array(i).slr.mean - result_array(i).fut.rc_best));
        pd_ex_fut_mn(i) = settings.gpd_return_period(idx);
    end   
end

hist_idx = [-inf,0.1,1,10,100,inf]';
tr_idx = (abs(loc_array(:,2))<=23.45);
nt_idx = (abs(loc_array(:,2))>23.45);

hist_ntr = zeros(numel(hist_idx)-1,2);
hist_tr =  zeros(numel(hist_idx)-1,2);
hist_all = zeros(numel(hist_idx)-1,2);

hist_ntr(:,2) = 0.145 + (0:0.2:0.8);
hist_tr(:,2)  = 0.1 + (0:0.2:0.8);
hist_all(:,2) = 0.055 + (0:0.2:0.8);

scn_rcp  = {'26','26','85','85','26','26','26','85','85','85'};
scn_ant  = {'0','0.1','0','0.1','0','0.15','0.3','0','0.3','0.6'};
scn_year = {'2050','2050','2050','2050','2100','2100','2100','2100','2100','2100'};

idx = find(settings.gpd_return_period==100);
for scn=1:numel(scn_ant)
    loadfile = strcat(extremes_dir,'RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.mat');
    load(loadfile)
    pd_ex_fut_mn = zeros(numel(result_array),1);
    for i=1:numel(result_array)
        acc = find(isfinite(result_array(i).pd.rc_mean));
        if result_array(i).slr.mean < result_array(i).pd.rc_mean(acc(1))
            pd_ex_fut_mn(i) = 0;
        else
            [~,idx] = nanmin(abs(result_array(i).slr.mean - result_array(i).pd.rc_mean));
            pd_ex_fut_mn(i) = settings.gpd_return_period(idx);
        end
    end

    dlmwrite(strcat(GMT_dir,'ratio_RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.txt'),[loc_array,pd_ex_fut_mn], 'delimiter',' ','precision','%.3f');
    
    % Histograms
    hist_all(:,1) =  histcounts(pd_ex_fut_mn,hist_idx)/numel(pd_ex_fut_mn);
    hist_tr(:,1)  =  histcounts(pd_ex_fut_mn(tr_idx),hist_idx)/sum(tr_idx);
    hist_ntr(:,1) =  histcounts(pd_ex_fut_mn(nt_idx),hist_idx)/sum(nt_idx);
    dlmwrite(strcat(GMT_dir,'hist_ntr_RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.txt'),hist_ntr, 'delimiter',' ','precision','%.3f');
    dlmwrite(strcat(GMT_dir,'hist_tr_RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.txt'),hist_tr, 'delimiter',' ','precision','%.3f');
    dlmwrite(strcat(GMT_dir,'hist_all_RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.txt'),hist_all, 'delimiter',' ','precision','%.3f');    
end




