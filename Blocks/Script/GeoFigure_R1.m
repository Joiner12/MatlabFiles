clc;
clear;
if ~isequal('D:\Codes\MatlabFiles\Blocks',pwd)
    cd('D:\Codes\MatlabFiles\Blocks')
    fprintf('Reload path: %s\n',pwd);
end
%% GEO
%{
    绘制地图坐标—数据可视化
%}
clc;
tic;
fprintf('geoscatter...\n');
EqFile = 'C:\Users\10520\Desktop\eqList2019.txt';
opt = detectImportOptions(EqFile);
opt.VariableNames =  {'Time','Level','Latitude','Longitude','Depth','Position'};
EqListOrigin = readtable(EqFile,opt);

%% 
sichuan = {};
size_temp = size(EqListOrigin);
cnt1 = 1;
for i=1:1:size_temp(1)
    if contains(EqListOrigin.Position(i),'四川')||contains(EqListOrigin.Position(i),'重庆')
        sichuan(cnt1).Position = EqListOrigin.Position(i);
        sichuan(cnt1).Time = EqListOrigin.Time(i);
        sichuan(cnt1).Level = EqListOrigin.Level(i);
        sichuan(cnt1).Latitude = EqListOrigin.Latitude(i);
        sichuan(cnt1).Longitude = EqListOrigin.Longitude(i);
        sichuan(cnt1).Depth = EqListOrigin.Depth(i);
        cnt1 = cnt1 + 1;
    end
    
end

%%
sichuan_table = struct2table(sichuan);
figure(1)
geobubble(sichuan_table.Latitude,sichuan_table.Longitude,sichuan_table.Level);
% Basemap colorterrain
title('2019年地震台网')
toc