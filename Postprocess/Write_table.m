clear all; close all; clc;
addpath(genpath('~/Scripts/matlab/'));
javaaddpath('/Users/tfrederi/Scripts/matlab/Utils/20130227_xlwrite/poi_library/poi-3.8-20120326.jar');
javaaddpath('/Users/tfrederi/Scripts/matlab/Utils/20130227_xlwrite/poi_library/poi-ooxml-3.8-20120326.jar');
javaaddpath('/Users/tfrederi/Scripts/matlab/Utils/20130227_xlwrite/poi_library/poi-ooxml-schemas-3.8-20120326.jar');
javaaddpath('/Users/tfrederi/Scripts/matlab/Utils/20130227_xlwrite/poi_library/xmlbeans-2.3.0.jar');
javaaddpath('/Users/tfrederi/Scripts/matlab/Utils/20130227_xlwrite/poi_library/dom4j-1.6.1.jar');

table_file    = '/Users/tfrederi//Documents/Papers/global_extremes_overleaf/DataCode/Results/result_table.xlsx';
extremes_dir = '~/Data/Extremes/Paper/esl_scenarios/';
filename_settings = strcat(extremes_dir,'settings.mat');
load(filename_settings)

filename = strcat(extremes_dir,'RCP26_2100_0.mat');
load(filename);

%% Cell array
loc_scale_arr = cell(numel(result_array)+1,10);
loc_scale_arr{1,1} = 'Name';
loc_scale_arr{1,2} = 'Longitude';
loc_scale_arr{1,3} = 'Latitude';
loc_scale_arr{1,4} = 'Location parameter';
loc_scale_arr{1,5} = 'Scale (5th percentile)';
loc_scale_arr{1,6} = 'Scale (50th percentile)';
loc_scale_arr{1,7} = 'Scale (95th percentile)';
loc_scale_arr{1,8} = 'Shape (5th percentile)';
loc_scale_arr{1,9} = 'Shape (50th percentile)';
loc_scale_arr{1,10} = 'Shape (95th percentile)';

%% Table 1: Schape, scale and location parameters
for i=1:numel(result_array)
    loc_scale_arr{i+1,1} = upper(result_array(i).name);
    loc_scale_arr{i+1,2} = result_array(i).lon;
    loc_scale_arr{i+1,3} = result_array(i).lat;
    loc_scale_arr{i+1,4} = result_array(i).gpd.loc;
    loc_scale_arr{i+1,5} = result_array(i).gpd.par_pct(1,2);
    loc_scale_arr{i+1,6} = result_array(i).gpd.par_pct(2,2);
    loc_scale_arr{i+1,7} = result_array(i).gpd.par_pct(3,2);
    loc_scale_arr{i+1,8} = result_array(i).gpd.par_pct(1,1);
    loc_scale_arr{i+1,9} = result_array(i).gpd.par_pct(2,1);
    loc_scale_arr{i+1,10} = result_array(i).gpd.par_pct(3,1);
end
xlwrite(table_file,loc_scale_arr,'GPD parameters');

%% 2050
ais  = {'0','0.05','0.1','0.15','0.2','0.3','0.45'};
year = [2050];
scn  = {'26','45','85'};
year_names = {'2046-2065'};
scn_names  = {'RCP2.6','RCP4.5','RCP8.5'};
ais_names  = {'0cm','5cm','10cm','15cm','20cm','30cm','45cm'};
for y=1:numel(year)
    for s=1:numel(scn)
        for a=1:numel(ais)
            sheet_name = strcat(year_names{y},{' '},scn_names{s},{' '},ais_names{a});
            data_arr = cell(numel(result_array)+1,7);
            data_arr{1,1} = 'Name';
            data_arr{1,2} = 'Longitude';
            data_arr{1,3} = 'Latitude';
            data_arr{1,4} = 'MSL change (mean)';
            data_arr{1,5} = 'MSL change (standard error)';
            data_arr{1,6} = 'Allowance';
            data_arr{1,7} = 'Amplification Factor';
            filename = strcat(extremes_dir,'RCP',scn{s},'_',num2str(year(y)),'_',ais{a},'.mat');
            load(filename)
            for i=1:numel(result_array)
                data_arr{i+1,1} = upper(result_array(i).name);
                data_arr{i+1,2} = result_array(i).lon;
                data_arr{i+1,3} = result_array(i).lat;
                data_arr{i+1,4} = result_array(i).slr.mean;
                data_arr{i+1,5} = result_array(i).slr.ste;
                data_arr{i+1,6} = result_array(i).fut.allowance;
                data_arr{i+1,7} = result_array(i).fut.amp_factor;
            end
            xlwrite(table_file,data_arr,sheet_name{1});
        end
    end
end

%% 2100
ais  = {'0','0.15','0.3','0.45','0.6','0.9','1.2','1.5'};
year = [2100];
scn  = {'26','45','85'};
year_names = {'2081-2100'};
scn_names  = {'RCP2.6','RCP4.5','RCP8.5'};
ais_names  = {'0cm','15cm','30cm','45cm','60cm','90cm','120cm','150cm'};
for y=1:numel(year)
    for s=1:numel(scn)
        for a=1:numel(ais)
            sheet_name = strcat(year_names{y},{' '},scn_names{s},{' '},ais_names{a});
            data_arr = cell(numel(result_array)+1,7);
            data_arr{1,1} = 'Name';
            data_arr{1,2} = 'Longitude';
            data_arr{1,3} = 'Latitude';
            data_arr{1,4} = 'MSL change (mean)';
            data_arr{1,5} = 'MSL change (standard error)';
            data_arr{1,6} = 'Allowance';
            data_arr{1,7} = 'Amplification Factor';
            
            filename = strcat(extremes_dir,'RCP',scn{s},'_',num2str(year(y)),'_',ais{a},'.mat');
            load(filename)
            for i=1:numel(result_array)
                data_arr{i+1,1} = upper(result_array(i).name);
                data_arr{i+1,2} = result_array(i).lon;
                data_arr{i+1,3} = result_array(i).lat;
                data_arr{i+1,4} = result_array(i).slr.mean;
                data_arr{i+1,5} = result_array(i).slr.ste;
                data_arr{i+1,6} = result_array(i).fut.allowance;
                data_arr{i+1,7} = result_array(i).fut.amp_factor;
            end
            xlwrite(table_file,data_arr,sheet_name{1});
        end
    end
end