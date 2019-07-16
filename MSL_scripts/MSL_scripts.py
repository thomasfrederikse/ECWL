# ---------------------------------------------------------------------
# Copyright (C) 2018-2019 Thomas Frederikse
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>
# ---------------------------------------------------------------------

# Create SROCC scenarios with Antarctic contribution afloat
import numpy as np
import os
import mod_msl_scenario as msl_scenario

settings = {}
settings['Datadir']     = os.getenv('HOME')   + '/Data/'
settings['save_dir']   = settings['Datadir'] + 'Extremes/Paper/'
settings['FP_thwaites'] = settings['Datadir'] + 'sle/Uniform/result_thwaites.nc'
settings['range_antarctica'] = np.array([0,0.05,0.1,0.15,0.20,0.30,0.45,0.6,0.9,1.2,1.5])
settings['rcp']  = 26
settings['year'] = 2100

scenario = {}
scenario['basis'] = msl_scenario.read_AR5_proj(settings['rcp'],settings['year'],settings)
fp_thwaites = msl_scenario.read_fp_thwaites(scenario['basis'],settings)

scenario['Antarctica'] = np.zeros(len(settings['range_antarctica']),dtype=dict)
for i in range(len(settings['range_antarctica'])):
    scenario['Antarctica'][i] = scenario['basis'].copy()
    scenario['Antarctica'][i] = msl_scenario.add_antarctic(scenario['Antarctica'][i], settings['range_antarctica'][i], 0, fp_thwaites, settings)
    scenario['Antarctica'][i] = msl_scenario.compute_total(scenario['Antarctica'][i],settings)
msl_scenario.save_scenarios(scenario,settings)
