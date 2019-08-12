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


%% Save amplification factors for the main text
clear all; close all; clc;
addpath(genpath('~/Scripts/matlab/'));

GMT_dir = '~/Scripts/GMT/Papers/global_extremes/Maintext/af/';
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

scn_rcp  = {'26','26','85','85','26','26','26','85','85','85'};
scn_ant  = {'0','0.1','0','0.1','0','0.15','0.3','0','0.3','0.6'};
scn_year = {'2050','2050','2050','2050','2100','2100','2100','2100','2100','2100'};

hist_idx = [0,25,50,75,100,inf]';
tr_idx = (abs(loc_array(:,2))<=23.45);
nt_idx = (abs(loc_array(:,2))>23.45);

hist_ntr = zeros(5,2);
hist_tr = zeros(5,2);
hist_all = zeros(5,2);

hist_ntr(:,2) = 5 + (0:25:100);
hist_tr(:,2) = 12.5 +  (0:25:100);
hist_all(:,2) = 20 +  (0:25:100);

for scn=1:numel(scn_rcp)
    loadfile = strcat(extremes_dir,'RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.mat');
    load(loadfile)
    amp_fac = zeros(numel(result_array),1);
    for i=1:numel(result_array)
        amp_fac(i) = result_array(i).fut.amp_factor;
    end
    hist_all(:,1) =  histcounts(amp_fac,hist_idx)/numel(amp_fac);
    hist_tr(:,1)  =  histcounts(amp_fac(tr_idx),hist_idx)/sum(tr_idx);
    hist_ntr(:,1) =  histcounts(amp_fac(nt_idx),hist_idx)/sum(nt_idx);
    dlmwrite(strcat(GMT_dir,'af_RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.txt'),[loc_array,amp_fac], 'delimiter',' ','precision','%.3f');
    dlmwrite(strcat(GMT_dir,'hist_ntr_RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.txt'),hist_ntr, 'delimiter',' ','precision','%.3f');
    dlmwrite(strcat(GMT_dir,'hist_tr_RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.txt'),hist_tr, 'delimiter',' ','precision','%.3f');
    dlmwrite(strcat(GMT_dir,'hist_all_RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.txt'),hist_all, 'delimiter',' ','precision','%.3f');
end