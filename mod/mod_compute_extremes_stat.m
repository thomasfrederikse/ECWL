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

function [result_lcl] = mod_compute_extremes_stat(msl_proj,station_lcl,settings)
%% Load station data
load(station_lcl.filename);

%% Determine local sea-level rise and 1 sigma uncertainty
[latmat,lonmat] = meshgrid(msl_proj.lat,msl_proj.lon);
dstmat = 1e10.*isnan(msl_proj.msl_mean) + 2.*asin(sqrt(sind(0.5.*(latmat-station_data.lat)).^2+cosd(station_data.lat).*cosd(latmat).*sind(0.5.*(lonmat-station_data.lon)).^2));
[lon_idx,lat_idx] = find(dstmat==min(dstmat(:)));

msl_mean = msl_proj.msl_mean(lon_idx,lat_idx);
msl_ste  = msl_proj.msl_ste(lon_idx,lat_idx);

%% Determine location parameter and values above GPD threshold
loc         = station_data.POT_values(abs(station_data.POT_values(:,1)-station_lcl.threshold)<1e-3,2);
extr_height = station_data.POT95_height(station_data.POT95_height>loc);
avg_exceed  = 365.25*24*numel(extr_height)./numel(station_data.height); % Average exceedances per  year for threshold

%% Fit distribution and covariance matrix
gpd_mean       = gpfit(extr_height-loc);
[~,gpd_covmat] = gplike(gpd_mean,extr_height-loc);

shape = gpd_mean(1);
scale = gpd_mean(2);

%% Generate random numbers from Pareto
random_gpd = mvnrnd(gpd_mean,gpd_covmat,settings.num_mc);
random_msl = normrnd(msl_mean,msl_ste,settings.num_mc,1);
random_shape   = random_gpd(:,1);
random_scale   = random_gpd(:,2);
random_scale(random_scale<0)=0; % Scale factor >= 0 as requirement. Normal distribution may generate <0
random_loc_fut = loc+random_msl;
gpd_parameters_pct = prctile(random_gpd,[5,50,95],1);

%% Compute ensemble of return curves
rc_rnd_pd  = zeros(numel(settings.gpd_return_period),settings.num_mc);
rc_rnd_fut = zeros(numel(settings.gpd_return_period),settings.num_mc);
for i=1:numel(settings.gpd_return_period)
    rc_rnd_pd(i,:)   = loc            + random_scale./random_shape .* ((settings.gpd_return_period(i)* avg_exceed).^random_shape - 1);
    rc_rnd_fut(i,:)  = random_loc_fut + random_scale./random_shape .* ((settings.gpd_return_period(i)* avg_exceed).^random_shape - 1);
end
rc_pd_mean  = mean(rc_rnd_pd,2);
rc_pd_pct   = prctile(rc_rnd_pd,[5,50,95],2);

%% Best-estimate return curve 
% for each ensemble member and height, compute expected return frequency after msl change.
% Then, select height for which mean return frequency stays the same 
height_range = loc+msl_mean+settings.allowance_range;

% Matrices for faster multiplication and division
estimate_mat = repmat(height_range,1,settings.num_mc);
loc_fut_mat  = repmat(random_loc_fut',numel(height_range),1);
scale_mat    = repmat(random_scale',numel(height_range),1);
shape_mat    = repmat(random_shape',numel(height_range),1);

% Create mask to rule out allowances that are smaller than the future location parameter and unbounded return periods
idx = true(size(estimate_mat));
idx(estimate_mat-loc_fut_mat<0) = false; % Allowance smaller than location parameter (GPD invalid)
idx((shape_mat.*(estimate_mat-loc_fut_mat)./scale_mat)<-1) = false; % Allowance higher than upper limit of GPD return height for negative shape parameters

% Create matrix of return periods for each height
ret_freq_mat = nan(size(estimate_mat));
ret_freq_mat(idx) = avg_exceed.*(1+(shape_mat(idx).*(estimate_mat(idx)-loc_fut_mat(idx))./scale_mat(idx))).^(-1./shape_mat(idx));

% For each MC ensemble and height, compute expected return period, equal to MC mean return period for each height
ret_freq_mean = nanmean(ret_freq_mat,2);

% Remove very unlikely events before interpolation (solves numerical problems)
height_range  = height_range(ret_freq_mean>1e-6);
ret_freq_mean = ret_freq_mean(ret_freq_mean>1e-6);

% Best estimate return heights: interpolation onto best-estimate return periods
rc_fut_best = interp1(1./ret_freq_mean(isfinite(1./ret_freq_mean)),height_range(isfinite(1./ret_freq_mean)),settings.gpd_return_period,'linear');

%% Amplification factor
idx_af_time = find(settings.gpd_return_period == settings.amp_factor_year);
idx_fut     = abs(rc_fut_best- rc_pd_mean(idx_af_time)) == min(abs(rc_fut_best - rc_pd_mean(idx_af_time)));
amp_factor  = settings.amp_factor_year / settings.gpd_return_period(idx_fut);

%% Allowance: best estimate return height change under constant return period
idx_al_time = find(settings.gpd_return_period == settings.allowance_year);
allowance   = rc_fut_best(idx_al_time) - rc_pd_mean(idx_al_time);
all_ratio   = allowance/msl_mean;

%% Save data in structure
result_lcl.msl.mean = msl_mean;
result_lcl.msl.ste  = msl_ste;

result_lcl.gpd.scale   = scale;
result_lcl.gpd.shape   = shape;
result_lcl.gpd.loc     = loc;
result_lcl.gpd.covmat  = gpd_covmat;
result_lcl.gpd.par_pct = gpd_parameters_pct;

result_lcl.pd.rc_obs   = [station_data.POT95_return_period(station_data.POT95_height>loc), extr_height] ;
result_lcl.pd.rc_mean  = rc_pd_mean;
result_lcl.pd.rc_pct   = rc_pd_pct;

result_lcl.fut.amp_factor  = amp_factor;
result_lcl.fut.allowance   = allowance;
result_lcl.fut.all_ratio   = all_ratio;
result_lcl.fut.rc_best     = rc_fut_best;
end
