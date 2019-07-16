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

function [msl_proj] = mod_read_msl_ais_proj(settings)
filename = strcat(settings.scenario_dir,'msl_rcp',num2str(settings.rcp),'_',num2str(settings.year),'.nc');
msl_proj.lon      = double(ncread(filename,'x'));
msl_proj.lat      = double(ncread(filename,'y'));
msl_proj.AIS_ctb  = double(ncread(filename,'AIS'));
msl_proj.msl_mean = double(ncread(filename,'total_slr'));
msl_proj.msl_ste  = double(ncread(filename,'total_slr_ste'));
end

