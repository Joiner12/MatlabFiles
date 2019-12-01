%{
    函数说明:
    @funcname:LADRC_TD(微分跟踪器)
    1.从带噪声的信号中提取或者回复原始信号，以得到原始信号的最佳逼近;
    2.解决不连续或者带有随机噪声的量测信号提取原始信号及微分信号问题;
    3.微分跟踪器采用最速综合函数，
    
    @param:p1 子函数fst_m中delta
    @param:p2 子函数fst_m中h
    @param:u 输入跟踪信号
    @param:t 采样周期

    [1]武利强, 韩京清. TD滤波器及其应用[J]. 计算技术与自动化, 2003, 22(s1):61-63.
%}
function [sys,x0,str,ts] = ADRC_TD(t,x,u,flag,p1,p2)

switch flag
    
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
        
    case 2
        sys = mdlUpdate(t,x,u,p1,p2);
        
    case 3
        sys = mdlOutputs(t,x,u);
        
    case {1,4,9}
        sys = [];
        
    otherwise
        DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
        
end

% ==========================================================================

function [sys,x0,str,ts] = mdlInitializeSizes

sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 2;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0,0];
str = [];
ts  = [1e-3 0];
% end mdlInitializeSizes

% ==========================================================================
function sys = mdlUpdate(t,x,u,p1,p2)
T = 1e-3;
vt = u;
h = p1;
delta = p2;

x(2) = x(2) + T*fst_m(vt,x(1),x(2),delta,h);
x(1) = x(1) + T*x(2);

sys = [x(1),x(2)];

% ==========================================================================
function sys = mdlOutputs(t,x,u)
sys = x;


