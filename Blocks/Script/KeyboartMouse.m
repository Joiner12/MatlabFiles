%% ��ͬ���嵱���Ա�
% sript path
clc;
Scriptpath = 'H:\MatlabFiles\���ж���\Scripts';
if ~isequal(Scriptpath,pwd)
    cd(Scriptpath)
end
fprintf('script path : %s\n',pwd);

%% ģ�����������
clc;clear;
import java.awt.Robot;
import java.awt.event.*;

robot = java.awt.Robot;

% ����ƶ�
robot.mouseMove(1,1)