%{
    ����������
    @func_name:LADRC_ESO
    @param:b
    @param:��1
    @param:��2
    @param:��3 | �۲����������
    (L)ESO
    1.���Ź۲�����ϵͳ�򻯳ɴ��������η���[1];
    2.��1 = 3*��0����2 = 3*��0^2,��3 = ��0^3[2];
    3.PD+LESO������KP =  3*��c^2 ,KD = 2*��c; ��cΪϵͳ����;

    ���Խ����2019��10��24�գ�
    1.���ض��󣺵��Ͷ��ױ��ض���(�أ�100,�ƣ�0.5))

    ESO:b0 = 150,��0 = 8,Kp=280,kd = 2;
    TD:�� = (10*ts(��������)) ��:5E6��


    [1]�ⵤ����ͮ���¿ң����ٵ����ŷ�ϵͳ�Կ��ſ��Ƶ��о���ʵ��������������Ӧ�ã�2013��30��12����1534-1542
    [2]Zhiqiang Gao, Scaling and bandwidth-parameterization based controller tuning, 2003, 4989-4996
    [3]����ADRC�㷨�Լ��������������Σ���һЩ�ĵ���� - ���������Ĳ��� - CSDN���ͣ�2019��2019-9-3��
    [4]����ΰ�������ӣ���Ԫ��ȣ�������ɢ����״̬�۲������ȶ��Է��������ۺϣ���Ϣ����ƣ�2008��02����135-139
    [5]�Ͷ��죬Фά�٣������Կ��ſ������Ĳ����򻯣��Զ����Ǳ�2007��05����27-28
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
function sys = mdlUpdate(~,x,u,beta1,beta2,beta3)
%{
    ��������:x = [z1(k),z2(k),z3(k)];
    ��������:u = [y(k),u(k)];
    ��������:x = [z1(k+1),z2(k+1),z3(k+1)];
%}
T = 1e-3;
h = T;
e = x(1) - u(1);
% z = [z1(k),z2(k),z3(k)];
z = zeros(1,3);
z(1) = x(1) + h*(x(2) - beta1*e);
z(2) = x(2) + h*(x(2) - beta2*e + u(2));
z(3) = x(3) - h*beta3*e;
x = z;
sys(1) = x(1);
sys(2) = x(2);
sys(3) = x(3);
%============================================================================
function sys = mdlOutputs(~,x,~)
sys = x;


