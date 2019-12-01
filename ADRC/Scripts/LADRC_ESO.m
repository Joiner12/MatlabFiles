%{
    函数说明：
    1.扩张状态观测器将系统视为串联积分形,一阶状态，二阶状态是系统的速度，加速度;
    2.二阶扩张观测器
    3.观测器参数，β1，β2，β3关系:
    β1 = 3*ω0，β2 = 3*ω0^2 β3 = ω0^3,ω0是观测器带宽，
    @Funcname:扩张观测器
    @param:beta1,观测器系数
    @param:beta3,观测器系数
    @param:beta2,观测器系数

    调试结果:
    1.被控对象：典型二阶被控对象[3]  
    2.调试参数：
    ESO:b0 = 150,ω0 = 8,Kp = 280,kd = 2;
    TD:α = 1e-2,δ = 5e6;
    
    
    reference:
    [1] 线性ADRC参数整定 https://blog.csdn.net/handsome_for_kill/article/details/88398467
    [2] 纪恩庆, 肖维荣. 二阶自抗扰控制器的参数简化[J]. 自动化仪表, 2007, 28(5).
    [3] H:\MatlabFiles\ADRC\Scripts\SystemModel_R1.m


%}
function [sys,x0,str,ts] = LADRC_ESO(t,x,u,flag,beta1,beta2,beta3)

switch flag
    
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
        
    case 2
        sys = mdlUpdate(t,x,u,beta1,beta2,beta3); 
        
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
sizes.NumDiscStates  = 3;
sizes.NumOutputs     = 3;
% u(1) = y(k),u(2) = ctrl_u
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0,0,0];
str = [];
ts  = [1e-3 0];
% end mdlInitializeSizes


% ==========================================================================
%{
    过程向量:x = [z1(k),z2(k),z3(k)];
    输入向量:u = [y(k),u(k)];
    输出向量:x = [z1(k+1),z2(k+1),z3(k+1)];
%}
function sys = mdlUpdate(t,x,u,beta1,beta2,beta3)
T = 1e-2;
h = T;
e = x(1) - u(2);
% z = [z1(k),z2(k),z3(k)];
z = zeros(1,3);
Continuous_Sys = false;
if Continuous_Sys
    % 连续形式
    z1 = x(2) - beta1*e;
    z2 = x(3) - beta2*e + u(2);
    z3 = -beta3*e;
    x = [z1,z2,z3];
else
    z(1) = x(1) + h*(x(2) - beta1*e);
    z(2) = x(2) + h*(x(3) - beta2*e + u(1));
    z(3) = x(3) - h*beta3*e;
end
x(1) = z(1);
x(2) = z(2);
x(3) = z(3);

sys(1) = x(1);
sys(2) = x(2);
sys(3) = x(3);

%============================================================================
function sys = mdlOutputs(t,x,u)
sys(1) = x(1);
sys(2) = x(2);
sys(3) = x(3);