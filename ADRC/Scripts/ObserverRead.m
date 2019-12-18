clc;
if ~isequal(pwd,'H:\MatlabFiles\ADRC\Scripts')
    cd('H:\MatlabFiles\ADRC\Scripts')
end
fprintf('Current Script Path:\n%s\n',pwd)

%% 系统观测器学习代码
%{
    1.欧几里得范数计算
    2.微分对噪声的模的放大（热噪声）
    3.系统能观、能控性判据
    4.分离定理
    5.降维观测器设计
%}

%% 范数
clc;
a = randi(10,1,10);
fprintf('欧氏范数:%.5f\n',norm(a,2));

%% 系统能观测|能控
% 系统矩阵
clc;
fprintf('control ability & observe ability\n');
A = [0 1; -1,0];
B = [1;0];
C = [1 0];
 
% 判断系统是否完全能控
E_con = ctrb(A,B);           % 求解能控性矩阵
E_val_con = rank(E_con)      % 根据能控性矩阵是否满秩判断能控性

E_obs = obsv(A,C);           % 求解能观性矩阵
E_val_obs = rank(E_obs)      % 根据能观性矩阵是否满秩判断能观性


%% 利用MATLAB中的acker函数求解状态观测器
clc ;
% 系统矩阵
A = [0 1; -1,0];B = [1;0];C = [1 0];
% 期望的极点
P = [-2;-2]; 
% 判断系统是否完全能观
E_obs = obsv(A,C);           
% 求解能观性矩阵
E_val = rank(E_obs);         
% 根据能控性矩阵是否满秩判断能观性 
L_acker = (acker(A',C',P))'
% 利用acker求状态增益矩阵L


%% ESO(I)
%{
    [1]Active disturbance rejection control:some recent experimental and industrial case studies
%}
clc;
b0 = 10;
A = [0 1 0;0 0 1;0 0 0]
B = [0;b0;0]
C = [1 0 0]
E = [0;0;1]
D = [0 0 0]
ss(A,B,C,D)


%% ESO(II)
%{
    LESO估计原理
    
    [1]Active Disturbance Rejection Control for Nonlinear Systems: An Introduction
%}
