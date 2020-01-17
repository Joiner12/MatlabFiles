%% 
clc;clear;
TargetPath = 'H:\MatlabFiles\ADRC\Scripts';
CurPath = pwd;
% if CurPath == TargetPath
if ~strcmp(CurPath,TargetPath)
    cd H:\MatlabFiles\ADRC
end
fprintf('Path...\n%s\t\t%s\n',pwd,'-');
clear ans CurPath TargetPath

%% 
clc;
[file,path] = uigetfile('C:\Users\Whtest\Desktop\*.txt');
if isequal(file,0)
    fprintf('File Selecting Canceled...\n');
    return
end

try 
    close('tag1')
    close('tag2')
catch 
    fprintf('no such figures opened\n');
end

filename = fullfile(path,file);
fprintf('load data from ''%s\'' \n',filename);
formatSpec = '%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', ','... 
    , 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
VarName1 = dataArray{:, 1}; % 模拟电压对应数字量(0-32768)
VarName2 = dataArray{:, 2}; % 编码器反馈(encoder)
VarName3 = dataArray{:, 3}; % 下位机工作状态
VarName4 = dataArray{:, 4}; % 工作子状态
VarTags = {'AD','Encoder','Status','ChildStatus'};
% 清除临时变量
clearvars filename delimiter formatSpec fileID dataArray ans;

%% 
fprintf('figure of datas \n')
figure('name','tag1')
subplot(221)
plot(VarName1)
grid minor
title(VarTags{1})

subplot(222)
plot(VarName2)
grid minor
title(VarTags{2})

subplot(223)
plot(VarName3)
grid minor
title(VarTags{3})

subplot(224)
plot(VarName4)
grid minor
title(VarTags{4})


figure('name','tag2')
subplot(221)
plot(VarName1)
grid minor
title(VarTags{1})

subplot(222)
plot(VarName2)
grid minor
title(VarTags{2})

subplot(223)
plot(VarName3)
grid minor
title(VarTags{3})

subplot(224)
plot(VarName4)
grid minor
title(VarTags{4})