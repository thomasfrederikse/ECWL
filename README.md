# ECWL
This set of scripts has been used to compute changes in extreme coastal water levels for the manuscript: 'The role of emission scenarios and Antarctica in 21st century extreme water level changes' by Thomas Frederikse et al.

## License
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

## Contents
 - MSL_scripts: Scripts used to compute mean sea-level changes from the AR5 estimates with a custom AIS contribution

 - GESLA_scripts: Scripts that read GESLA2 database, compute de-clustered extreme events above threshold, and save as '.mat' file for quick IO

 - Extremes_scripts: Main code that computes the return curves, allowances, and amplification factors

 - Postprocess: Postprocessing of the results for plotting

 - GMT: GMT codes used to create all plots

 - FP_thwaites: contains a netcdf with the sea-level fingerprint for Thwaites glacier

 - mod: contains modules that are called by the other scripts


## How to use these scripts
First, download all necessary data, see below, and make sure to change all paths: they won't automagically point towards the right path. Also make sure that your matlab/python interpreter has the mod folder in its search path.

## MSL_scripts
These scripts (Python) compute the mean sea-level scenarios by adding a custom Antarctica scenario to the AR5 scenarios. This requires the original AR5 scenarios, which can be found from https://icdc.cen.uni-hamburg.de/1/daten/ocean/ar5-slr.html.

## GESLA_scripts
To save a lot of time, the scripts (matlab) in GESLA_scripts read the GESLA2 text files (Get the database from https://gesla.org/), pre-compute the peak-over-threshold data, and save everything in a .mat file.

## Extremes_scripts
The main computation scripts, in matlab

## Postprocess
matlab scripts that read the results, and save them in text format for GMT to be plotted. Also contains 'write_table.m', which creates a table with all results

## GMT
GMT scripts to plot all figures from the main text and supporting information. Get GMT here: https://github.com/GenericMappingTools/gmt. The plots use, and the scripts include some colormaps from:
- Cynthia Brewer's ColorBrewer2 (http://colorbrewer2.org and http://soliton.vm.bytemark.co.uk/pub/cpt-city/jjg/cbcont/index.html)
- Fabio Crameri (http://www.fabiocrameri.ch/colourmaps.php)
- The cmocean set (Thyng, K. M., Greene, C. A., Hetland, R. D., Zimmerle, H. M., & DiMarco, S. F. (2016). True colors of oceanography. Oceanography, 29(3), 10. link: [http://tos.org/oceanography/assets/docs/29-3_thyng.pdf])

## FP_thwaites
Contains the input load and the resulting sea-level fingerprints for uniform mass loss from Thwaites.

## mod
All modules called by other routines

## Results
This directory contains the results. The files 'allowance_table.pdf' and 'amp_factor_table.pdf' contain the allowances and amplification factors for each station and scenario shown in the main text. The folder also contains the netCDF files with all the mean sea level scenarios and the accompanying uncertainties. The file 'esl_results.xlsx' contains the estimated GPD parameters for each tide-gauge site, as well as the estimated 100-year amplification factor and allowance for all scenarios shown in the SUpplementary Information.
