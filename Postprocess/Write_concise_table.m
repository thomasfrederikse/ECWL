clear all; close all; clc;
addpath(genpath('~/Scripts/matlab/'));

% Path to the xlwrite toolbox
javaaddpath('/Users/tfrederi/Scripts/matlab/Utils/20130227_xlwrite/poi_library/poi-3.8-20120326.jar');
javaaddpath('/Users/tfrederi/Scripts/matlab/Utils/20130227_xlwrite/poi_library/poi-ooxml-3.8-20120326.jar');
javaaddpath('/Users/tfrederi/Scripts/matlab/Utils/20130227_xlwrite/poi_library/poi-ooxml-schemas-3.8-20120326.jar');
javaaddpath('/Users/tfrederi/Scripts/matlab/Utils/20130227_xlwrite/poi_library/xmlbeans-2.3.0.jar');
javaaddpath('/Users/tfrederi/Scripts/matlab/Utils/20130227_xlwrite/poi_library/dom4j-1.6.1.jar');

table_file_af    = '/Users/tfrederi//Documents/Papers/global_extremes_overleaf/DataCode/Results/result_concise_table_af_interim.xlsx';
table_file_al    = '/Users/tfrederi//Documents/Papers/global_extremes_overleaf/DataCode/Results/result_concise_table_al_interim.xlsx';

extremes_dir = '~/Data/Extremes/Paper/esl_scenarios/';
filename_settings = strcat(extremes_dir,'settings.mat');
load(filename_settings)

filename = strcat(extremes_dir,'RCP26_2050_0.mat');
load(filename);

% Sort the array by country
[clist,arg_sort] = sort([result_array.country]);
result_array = result_array(arg_sort);

%% Amplification factors 2050
header_table = cell(numel(result_array)+4,12);
header_table{1,1} = 'Year';
header_table{2,1} = 'Emission Scenario';
header_table{3,1} = 'Antarctic Ice Sheet contribution (cm)';
header_table{4,1} = 'Country';
header_table{4,2} = 'Site name';

% Fill names
for i=1:numel(result_array)
    header_table{i+4,1} = clist{i};
    header_table{i+4,2} = upper(result_array(i).name);
end

% Scenarios
scn_rcp  = {'26','26','85','85','26','26','26','85','85','85'};
scn_ant  = {'0','0.1','0','0.1','0','0.15','0.3','0','0.3','0.6'};
scn_year = {'2050','2050','2050','2050','2100','2100','2100','2100','2100','2100'};
for scn=1:numel(scn_rcp)
    % Fill header
    if strcmp(scn_year(scn),'2050')
        header_table{1,scn+2} = '2046-2065';
    else 
        header_table{1,scn+2} = '2081-2100';
    end
    if strcmp(scn_rcp(scn),'26')
        header_table{2,scn+2} = 'RCP2.6';
    else 
        header_table{2,scn+2} = 'RCP8.5';
    end
    header_table{3,scn+2} = num2str(round(str2double(scn_ant{scn})*100));
end
AF = header_table;
Al = header_table;

for scn=1:numel(scn_rcp)
    loadfile = strcat(extremes_dir,'RCP',scn_rcp{scn},'_',scn_year{scn},'_',scn_ant{scn},'.mat');
    load(loadfile)
    result_array = result_array(arg_sort);
    for i=1:numel(result_array)
        AF{i+4,scn+2} = result_array(i).fut.amp_factor;
        Al{i+4,scn+2} = 100*result_array(i).fut.allowance;
    end
end
xlwrite(table_file_af,AF);
xlwrite(table_file_al,Al);


  




