%{
    ADRC-ESO;
    second-order 自抗扰扩张观测器;
    @ parameters:[alpha01,alpha02,beta01,beta02,beta03,b0]
    alpha:fal函数非线性度参数
    beta:eso各阶估计器系数
    b0:输入增益
    
    reference:
    [1] I:\期刊文献\2019年5月25日\Control and Simulation of the ABS based on ADRC.pdf
    [2] I:\电子书\控制工程\自抗扰控制技术-估计补偿不确定因素的控制技术.pdf page.188
%}
function [sys,x0,str,ts] = ADRC_ESO(t,x,u,flag,alpha01,alpha02,beta01,beta02,beta03,b0)

switch flag
    
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
        
    case 2
        sys = mdlUpdate(t,x,u,alpha01,alpha02,beta01,beta02,beta03,b0);
        
    case 3
        sys = mdlOutputs(t,x);
        
    case {1,4,}
        sys = [];
        
    case 9
        sys = mdlTerminate(t,x,u);
        
    otherwise
        DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
        
end

% ==========================================================================

function [sys,x0,str,ts] = mdlInitializeSizes

sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 3;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 2;
%{
    直接馈通
    如果输出函数mdlOutputs
    或者对于变采样时间的mdlGetTimeOfNextVarHit是输入u的函数，
    则模块具有直接馈通的特性sizes.DirFeedthrough=1;否则为0。
%}
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0,0,0];
str = [];
ts  = [1e-3 0];
% end mdlInitializeSizes

% ==========================================================================
function sys = mdlUpdate(~,x,u,alpha01,alpha02,beta01,beta02,beta03,b0)
x = zeros(1,3);
sys = x;

% ==========================================================================
function sys = mdlOutputs(~,x)
sys = x;

% ==========================================================================
function sys = mdlTerminate(~,~,~)
sys = [];
fprintf('ADRC Simulation Finished\n');
