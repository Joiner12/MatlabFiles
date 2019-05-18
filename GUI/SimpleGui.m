%% dos 数据采集 绘制图片并保存
clc;close all;
fprintf('>>>数据采集 | 图片绘制<<<\n')

promt = '关闭当前Matlab显示绘图 ? Y/N [Y]:';
isClose = input(promt,'s');
if isequal(isClose,'Y') || isequal(isClose,'y')
    close all;
else
    disp('keep them visualable')
end

[file,path] = uigetfile('*.txt');
if isequal(file,0)
    disp('No *.txt file Selected')
    return
end

VariableName = ["","","","","","",""];
