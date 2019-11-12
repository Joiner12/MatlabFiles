% 微分跟踪器
%{
    复合微分跟踪器(Compound TD)
    
    reference：
    [1]劳立明，陈英龙，赵玉刚等，跟踪微分器的等效线性分析及优化，浙江大学学报(工学版)，2018，52（02），224-232
%}
function [sys,x0,str,ts] = TDB(t,x,u,flag,p1,p2,p3)
switch flag
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 2
        sys = mdlUpdate(t,x,u,p1,p2,p3);
    case 3
        sys = mdlOutputs(t,x,u);
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
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed
sys = simsizes(sizes);
x0  = [0,0];
u = [0,0]
str = [];
ts  = [1e-3 0];

%=============================================================================
function sys = mdlUpdate(~,x,u,p1,p2,p3)
T = 1e-3;
vt = u(1);
v1 = u(2);
% T一般取5~10
h = p1*T;
delta = p2;

x(1) = x(1) + T*x(2);
x(2) = x(2) + T*fst_m(vt,x(1),x(2),delta,h) + p3*v1;

sys = [x(1),x(2)];

%=============================================================================
function sys=mdlOutputs(~,x,~)
sys = x;