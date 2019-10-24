% 微分跟踪器
%{
    函数说明：
    @funcname:ADRC_TD
    1.从带噪声信号中提取原始信号，以及高阶段信号;
    3.微分跟踪器采用最速综合函数原理实现;

    @parameter:p1 最速综合函数fst_m中delta
    @parameter:p2 fst_m中h
    @parameter:u 输入跟踪信号
    @parameter:t 采样周期

    reference：
    [1] 韩京清，武利强，TD滤波器及其应用
%}
function [sys,x0,str,ts] = ADRC_TD(t,x,u,flag,p1,p2)
switch flag
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 2
        sys=mdlUpdate(t,x,u,p1,p2);
    case 3
        sys=mdlOutputs(t,x,u);
    case{1,4,9}
        sys = [];

    otherwise
        DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end

%=============================================================================
function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 2;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed
sys = simsizes(sizes);
x0  = [0,0];
str = [];
ts  = [1e-3 0];

%=============================================================================
function sys = mdlUpdate(~,x,u,p1,p2)
T = 1e-3;
vt = u;
% T一般取5~10
h = p1*T;
delta = p2;

x(1) = x(1) + T*x(2);
x(2) = x(2) + T*fst_m(vt,x(1),x(2),delta,h);

sys = [x(1),x(2)];

%=============================================================================
function sys=mdlOutputs(~,x,~)
sys = x;