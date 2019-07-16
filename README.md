# ECWL
This set of scripts has been used to compute changes in extreme coastal water levels for the manuscript: 'The role of emission scenarios and Antarctica in 21st century extreme water level changes' by Thomas Frederikse et al.

## Contents
 - MSL_scripts: Scripts used to compute mean sea-level changes from the AR5 estimates with a custom AIS contribution
 
 - GESLA_scripts: Scripts that read GESLA2 database, compute de-clustered extreme events above threshold, and save as '.mat' file for quick IO
 
 - Extremes_scripts: Main code that computes the return curves, allowances, and amplification factors
 
 - Postprocess: Postprocessing of the results for plotting
 
 - GMT: GMT codes used to create all plots
 
 - mod: contains modules files used by the other scripts
 
## MSL_scripts
These scripts (Python) compute the mean sea-level scenarios by adding a custom Antarctica scenario to the AR5 scenarios. This requires the original AR5 scenarios, which can be found from https://icdc.cen.uni-hamburg.de/1/daten/ocean/ar5-slr.html. 

## GESLA_scripts
To save a lot of time, the scripts (matlab) in GESLA_scripts read the GESLA2 text files (Get the database from https://gesla.org/), pre-compute the peak-over-threshold data, and save everything in a .mat file. 

