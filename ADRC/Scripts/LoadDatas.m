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
    1.΢�ָ�������������
    1.1 ������Դ��ʵʱ�ɼ�����������2ms�����ݴ������������壬���嵱��0.001;
    1.2 ԭʼ����(1)λ��"C:\\Users\\Whtest\\Desktop\\Coder\\Shallow\\Shallow\\Src\\datatest.txt";
    1.3 ԭʼ����(2)λ�ã�H:\MatlabFiles\WavePanel\Scripts\fixedCapHeight.mat��
    1.4 ����(3):  H:\MatlabFiles\ADRC\Scripts\sstep.mat %ģ���Ծ�ź�;
    sstep.mat�ֶ����ɵĽ�Ծ�ź�(timeseries,capheight)���ṩ��simulink����ʹ��;
    1.5 ����(4):  H:\MatlabFiles\ADRC\Scripts\simudata.mat;
    simudata.mat�ǽ�fixedCapHeight.mat���ݽ������ϣ�����(timeseries,capheight)���ݹ�simulink ����ʹ��;
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
    % ��Ծ�ź�
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