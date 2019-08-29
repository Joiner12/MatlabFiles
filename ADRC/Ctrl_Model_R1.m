% Created date:2019-8-28
% 
clc;
disp('Mathmatic model block ')
PurposePath = 'D:\Codes\MatlabFiles\ADRC';
if ~strcmp(PurposePath,pwd)
    cd D:\Codes\MatlabFiles\ADRC
end
fprintf('load path...\nt%s\n',pwd)
clear ans

%% part ¢Ò nonliner system identification
clc;clear;
load twotankdata.mat
Ts = 0.2; % s
z = iddata(y,u,Ts);
ze = z(1:1000);
zv = z(1001:end);

% …Ë÷√ Ù–‘
ze.TimeUnit = 'sec';% Set time units to minutes

ze.InputName = 'Voltage';% Set names of input channels

ze.InputUnit = 'V';% Set units for input variables

ze.OutputName = 'Height';% Set name of output channel

ze.OutputUnit = 'm';% Set unit of output channel
% Set validation data properties
zv.TimeUnit = 'sec';
zv.InputName = 'Voltage';
zv.InputUnit = 'V';
zv.OutputName = 'Height';
zv.OutputUnit = 'm';
