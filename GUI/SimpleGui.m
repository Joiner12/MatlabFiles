%% dos ���ݲɼ� ����ͼƬ������
clc;close all;
fprintf('>>>���ݲɼ� | ͼƬ����<<<\n')

promt = '�رյ�ǰMatlab��ʾ��ͼ ? Y/N [Y]:';
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
