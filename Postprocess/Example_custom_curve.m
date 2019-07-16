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

%% Create a custom GPD exampple
close all
settings.gpd_return_period = 10.^(-2:0.02:4)';
GMT_dir = '~/Scripts/GMT/Papers/global_extremes/Rev_AIS/example/';

loc   = 0.2;
loc_fut = 0.8;
scale = 0.35;
shape = -0.1;

pd_return_height     = loc     + scale/shape * ((settings.gpd_return_period*365.24*24 * 1/100).^shape - 1);
future_return_height = loc_fut + scale/shape * ((settings.gpd_return_period*365.24*24 * 1/100).^shape - 1);

figure()
semilogx(settings.gpd_return_period,pd_return_height)
hold on
semilogx(settings.gpd_return_period,future_return_height)
semilogx(settings.gpd_return_period,future_return_height)

idx_pd   = find(settings.gpd_return_period==100);
% AF arrow
idx_fut  = find(abs(future_return_height-pd_return_height(idx_pd))==min(abs(future_return_height-pd_return_height(idx_pd))));
AF_fut   = settings.gpd_return_period(idx_fut);

af_arrow_h  = [AF_fut, pd_return_height(idx_pd);100,pd_return_height(idx_pd)];
af_arrow_v1 = [AF_fut,0;AF_fut,pd_return_height(idx_pd)];
af_arrow_v2 = [100,0;100,pd_return_height(idx_pd)];

% Allowance arrow
all_arrow = [100, pd_return_height(idx_pd);100,future_return_height(idx_pd)];


% Save lines
dlmwrite(strcat(GMT_dir,'ex_gpd_pd.txt'), [settings.gpd_return_period,pd_return_height],     'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'ex_gpd_fut.txt'),[settings.gpd_return_period,future_return_height], 'delimiter',' ','precision','%.3f');

% Save arrows
dlmwrite(strcat(GMT_dir,'af_1.txt'),af_arrow_h, 'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'af_2.txt'),af_arrow_v1,'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'af_3.txt'),af_arrow_v2,'delimiter',' ','precision','%.3f');
dlmwrite(strcat(GMT_dir,'all_1.txt'),all_arrow, 'delimiter',' ','precision','%.3f');
