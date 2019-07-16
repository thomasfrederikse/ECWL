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


# Modules to create MSL scenarios
import numpy as np
from netCDF4 import Dataset

def read_AR5_proj(rcp,year,settings):
    # Read all components from AR5
    filename = settings['Datadir'] + 'AR5/component-ts-slr-'+str(rcp)+'.nc'
    time = np.arange(2007, 2101)
    if year == 2100: y_idx = time >= 2081
    if year == 2050: y_idx = np.logical_and(time >= 2046, time <= 2065)
    scenario = {}

    file_handle = Dataset(filename, 'r')
    scenario['lon'] = file_handle.variables["lon"][:]
    scenario['lat'] = file_handle.variables["lat"][:]

    scenario['contrib'] = {}
    scenario['contrib']['GrIS_smb'] = read_indiv(file_handle,y_idx,'greensmb')
    scenario['contrib']['GrIS_dyn'] = read_indiv(file_handle,y_idx,'greendyn')
    scenario['contrib']['Glaciers'] = read_indiv(file_handle,y_idx,'glac')
    scenario['contrib']['Ocean']    = read_indiv(file_handle,y_idx,'ocn')
    scenario['contrib']['TWS']      = read_indiv(file_handle,y_idx,'grw')
    scenario['contrib']['GIA']      = read_gia(file_handle,y_idx)
    return(scenario)

def read_indiv(file_handle,y_idx,name):
    # Read individual contributor from AR5
    contrib = {}
    mn = np.mean(file_handle.variables[name+"_m"][y_idx,:,:]._get_data(),axis=0)
    hi = np.mean(file_handle.variables[name+"_h"][y_idx,:,:]._get_data(),axis=0)
    lo = np.mean(file_handle.variables[name+"_l"][y_idx,:,:]._get_data(),axis=0)
    mn[mn>1.0e20] = np.nan
    hi[hi>1.0e20] = np.nan
    lo[lo>1.0e20] = np.nan
    ste = np.abs(0.5 * (hi-lo))/1.645
    contrib['mean']  = mn
    contrib['sterr'] = ste
    return(contrib)

def read_gia(file_handle,y_idx):
    contrib = {}
    gia_m  = np.mean(file_handle.variables["gia_m"][y_idx,:,:]._get_data(),axis=0)
    gia_sd = np.mean(file_handle.variables["gia_sd"][y_idx,:,:]._get_data(),axis=0)
    gia_m[gia_m>1.0e20] = np.nan
    gia_sd[gia_sd>1.0e20] = np.nan
    contrib['mean']  = gia_m
    contrib['sterr'] = gia_sd
    return(contrib)

def add_antarctic(scenario,ant_ctb,ant_ste,fp_ant,settings):
    scenario['contrib']['AIS'] = {}
    scenario['contrib']['AIS']['mean'] = ant_ctb * fp_ant
    scenario['contrib']['AIS']['sterr'] = np.abs(ant_ste * fp_ant)
    return(scenario)

def compute_total(scenario,settings):
    scenario['total'] = {}
    scenario['total']['mean'] = np.zeros([len(scenario['lat']),len(scenario['lon'])])
    for i in scenario['contrib']:
        scenario['total']['mean'] = scenario['total']['mean'] + scenario['contrib'][i]['mean']
    # Dependent and independent vars
    dep_vars = (scenario['contrib']['Ocean']['sterr']+scenario['contrib']['GrIS_smb']['sterr'])**2
    ind_vars = scenario['contrib']['Glaciers']['sterr']**2 + scenario['contrib']['GrIS_dyn']['sterr']**2 + scenario['contrib']['AIS']['sterr']**2 + scenario['contrib']['TWS']['sterr']**2 + scenario['contrib']['GIA']['sterr']**2
    scenario['total']['sterr'] = np.sqrt(dep_vars + ind_vars)

    # Compute GMSL for the scenario
    area = compute_area(scenario['lon'],scenario['lat'],1)
    scenario['total']['gmsl'] = np.nansum(area*scenario['total']['mean']) / np.sum(area*np.isfinite(scenario['total']['mean']))
    return(scenario)

def read_fp_thwaites(scenario,settings):
    loaddata = Dataset(settings['FP_thwaites'], 'r')
    fp_thwaites_05 = loaddata.variables["RSL"][:]._get_data()
    lon_05 = loaddata.variables["x"][:]._get_data()
    lat_05 = loaddata.variables["y"][:]._get_data()
    loaddata.close()

    # Regrid to 1 degree field
    fp_thwaites = 1000 * nearest_n(lon_05, lat_05, fp_thwaites_05, scenario['lon'], scenario['lat'])
    return(fp_thwaites)

def save_scenarios(scenario,settings):
    # Save data in single file
    # Create 3D arrays
    scen_mean = np.zeros([len(settings['range_antarctica']),len(scenario['basis']['lat']),len(scenario['basis']['lon'])])
    scen_sterr = np.zeros([len(settings['range_antarctica']),len(scenario['basis']['lat']),len(scenario['basis']['lon'])])
    scen_gmsl = np.zeros(len(settings['range_antarctica']))
    for i in range(len(settings['range_antarctica'])):
        scen_mean[i,:,:]    = scenario['Antarctica'][i]['total']['mean']
        scen_sterr[i, :, :] = scenario['Antarctica'][i]['total']['sterr']
        scen_gmsl[i] = scenario['Antarctica'][i]['total']['gmsl']

    # Save
    filename = settings['save_dir'] +'msl_scenarios/'+ 'msl_rcp'+ str(settings['rcp'])+'_'+str(settings['year'])+'.nc'
    file_handle = Dataset(filename, 'w')
    file_handle.createDimension('x',   len(scenario['basis']['lon']))
    file_handle.createDimension('y',   len(scenario['basis']['lat']))
    file_handle.createDimension('AIS', len(settings['range_antarctica']))

    x   = file_handle.createVariable('x', 'f4', ('x',))
    y   = file_handle.createVariable('y', 'f4', ('y',))
    AIS = file_handle.createVariable('AIS', 'f4', ('AIS',))
    GMSL = file_handle.createVariable('GMSL', 'f4', ('AIS',))

    total_slr     = file_handle.createVariable('total_slr', 'f4', ('AIS','y', 'x',))
    total_slr_ste = file_handle.createVariable('total_slr_ste', 'f4', ('AIS','y', 'x',))

    x[:] = scenario['basis']['lon']
    y[:] = scenario['basis']['lat']
    AIS[:] = settings['range_antarctica']
    GMSL[:] = scen_gmsl
    total_slr[:] = scen_mean
    total_slr_ste[:] = scen_sterr
    file_handle.close()
    return

def compute_area(lon,lat,grid):
    # Compute area of each grid cell
    lon,lat = np.meshgrid(lon,lat)
    radius = 6371000
    area =  (np.deg2rad(lon+grid/2)-np.deg2rad(lon-grid/2)) * (np.sin(np.deg2rad(lat+grid/2)) - np.sin(np.deg2rad(lat-grid/2)))  * radius**2
    return area

def nearest_n(lon,lat,data_in,lonq,latq):
    # Compute neirest-neighboor interpolation
    data_out = np.zeros([latq.size,lonq.size])
    for i in np.arange(latq.size):
        lati = np.argmin(np.abs(lat-latq[i]))
        for j in np.arange(lonq.size):
            loni = np.argmin(np.abs(lon-lonq[j]))
            data_out[i,j] = data_in[lati,loni]
    return(data_out)
