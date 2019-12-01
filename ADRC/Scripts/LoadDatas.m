%path
clc;clear;
TargetPath = 'H:\MatlabFiles\ADRC';
CurPath = pwd;
% if CurPath == TargetPath
if strcmp(CurPath,TargetPath)
    fprintf('Road...%s\t\n%s\n',pwd,'ADRC');
else
    cd H:\MatlabFiles\ADRC
end
clear ans CurPath TargetPath

%%
%{
    1.微分跟踪器测试数据
    1.1 数据来源：实时采集，采样周期2ms，电容传感器反馈脉冲，脉冲当量0.001;
    1.2 原始数据(1)位置"C:\\Users\\Whtest\\Desktop\\Coder\\Shallow\\Shallow\\Src\\datatest.txt";
    1.3 原始数据(2)位置：H:\MatlabFiles\WavePanel\Scripts\fixedCapHeight.mat；
    1.4 数据(3):  H:\MatlabFiles\ADRC\Scripts\sstep.mat %模拟阶跃信号;
    sstep.mat手动生成的阶跃信号(timeseries,capheight)，提供给simulink仿真使用;
    1.5 数据(4):  H:\MatlabFiles\ADRC\Scripts\simudata.mat;
    simudata.mat是将fixedCapHeight.mat数据进行整合，生成(timeseries,capheight)数据供simulink 仿真使用;
%}
clc;
load H:\MatlabFiles\WavePanel\Scripts\fixedCapHeight.mat;
origin = load("C:\\Users\\Whtest\\Desktop\\Coder\\Shallow\\Shallow\\Src\\datatest.txt");

dataSrc = 'three';
switch dataSrc
    case 'one'
        timeser = fixedCapHeight.InputData;
        capheight = fixedCapHeight.OutputData;
    case 'two'
        timeser = 1e-3.*linspace(0,length(origin-1),length(origin-1));
        capheight = origin;
        simudata = [timeser',capheight];
    % 阶跃信号
    case 'three'
        timeser = 1e-3.*linspace(0,length(origin)-1,length(origin)-1);
        timeser = timeser';
        temp = linspace(10000,10000,length(origin) - 101);
        temp = temp';
        temp = [zeros(100,1);temp];
        sstep = [timeser,temp];
    otherwise
        fprintf('no such data choice\n')
end