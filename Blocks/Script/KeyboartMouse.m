%% 不同脉冲当量对比
% sript path
clc;
Scriptpath = 'H:\MatlabFiles\管切抖纹\Scripts';
if ~isequal(Scriptpath,pwd)
    cd(Scriptpath)
end
fprintf('script path : %s\n',pwd);

%% 模拟键盘鼠标操作
clc;clear;
import java.awt.Robot;
import java.awt.event.*;

robot = java.awt.Robot;

% 鼠标移动
robot.mouseMove(1,1)