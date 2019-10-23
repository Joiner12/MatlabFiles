%{
    函數描述：
    @func_name:LADRC_ESO
    @param:b
    @param:β1
    @param:β2
    @param:β3 | 观测器增益矩阵
    (L)ESO
    1.扩张观测器将系统简化成串联积分形反馈[1];
    2.β1 = 3*ω0，β2 = 3*ω0^2,β3 = ω0^3[2];
    3.PD+LESO参数，KP =  3*ωc^2 ,KD = 2*ωc; ωc为TD带宽;
    [1]吴丹，赵彤，陈恳，快速刀具伺服系统自抗扰控制的研究与实践，控制理论与应用，2013，30（12），1534-1542
    [2]Zhiqiang Gao, Scaling and bandwidth-parameterization based controller tuning, 2003, 4989-4996
    [3]关于ADRC算法以及参数整定（调参）的一些心得体会 - 西涯先生的博客 - CSDN博客，2019（2019-9-3）
    [4]邵立伟，廖晓钟，夏元清等，三阶离散扩张状态观测器的稳定性分析及其综合，信息与控制，2008（02），135-139
%}

function [sys,x0,str,ts] = LADRC_ESO(t,x,u,flag,b,beta1,beta2,beta3)
switch flag
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 2
        sys = mdlUpdate(t,x,u,b,beta1,beta2,beta3);
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
sizes.NumDiscStates  = 3;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0,0,0];
str = [];
ts  = [1e-3 0];


%=============================================================================
function sys = mdlUpdate(~,x,u,b,beta1,beta2,beta3)
%{
    过程向量:x = [z1(k),z2(k),z3(k)];
    输入向量:u = [y(k),u(k)];
    输入向量:x = [z1(k+1),z2(k+1),z3(k+1)];
%}
b_0 = b;
T = 1e-3;
h = T;
e = x(1) - u(1);
% z = [z1(k),z2(k),z3(k)];
z = zeros(1,3);
Continuous_Sys = false;
if Continuous_Sys
    % 连续形式
    z1 = x(2) - beta1*e;
    z2 = x(3) - beta2*e + b_0*u(2);
    z3 = -beta3*e;
    x = [z1,z2,z3];
else
    z(1) = x(1) + h*(x(2) - beta1*e);
    z(2) = x(2) + h*(x(2) - beta2*e + b_0*u(2));
    z(3) = x(3) - h*beta3*e;
end
x = z;
sys(1) = x(1);
sys(2) = x(2);
sys(3) = x(3);
%============================================================================
function sys = mdlOutputs(~,x,~)
sys = x;


