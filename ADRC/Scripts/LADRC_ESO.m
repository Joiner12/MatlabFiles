%{
    ����˵����
    1.����״̬�۲�����ϵͳ��Ϊ����������,һ��״̬������״̬��ϵͳ���ٶȣ����ٶ�;
    2.�������Ź۲���
    3.�۲�����������1����2����3��ϵ:
    ��1 = 3*��0����2 = 3*��0^2 ��3 = ��0^3,��0�ǹ۲�������
    @Funcname:���Ź۲���
    @param:beta1,�۲���ϵ��
    @param:beta3,�۲���ϵ��
    @param:beta2,�۲���ϵ��

    ���Խ��:
    1.���ض��󣺵��Ͷ��ױ��ض���[3]  
    2.���Բ�����
    ESO:b0 = 150,��0 = 8,Kp = 280,kd = 2;
    TD:�� = 1e-2,�� = 5e6;
    
    
    reference:
    [1] ����ADRC�������� https://blog.csdn.net/handsome_for_kill/article/details/88398467
    [2] �Ͷ���, Фά��. �����Կ��ſ������Ĳ�����[J]. �Զ����Ǳ�, 2007, 28(5).
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
    ��������:x = [z1(k),z2(k),z3(k)];
    ��������:u = [y(k),u(k)];
    �������:x = [z1(k+1),z2(k+1),z3(k+1)];
%}
function sys = mdlUpdate(t,x,u,beta1,beta2,beta3)
T = 1e-2;
h = T;
e = x(1) - u(2);
% z = [z1(k),z2(k),z3(k)];
z = zeros(1,3);
Continuous_Sys = false;
if Continuous_Sys
    % ������ʽ
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