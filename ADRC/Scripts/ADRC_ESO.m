%{
    ADRC-ESO;
    second-order �Կ������Ź۲���;
    @ parameters:[alpha01,alpha02,beta01,beta02,beta03,b0]
    alpha:fal���������ԶȲ���
    beta:eso���׹�����ϵ��
    b0:��������
    
    reference:
    [1] I:\�ڿ�����\2019��5��25��\Control and Simulation of the ABS based on ADRC.pdf
    [2] I:\������\���ƹ���\�Կ��ſ��Ƽ���-���Ʋ�����ȷ�����صĿ��Ƽ���.pdf page.188
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
    ֱ����ͨ
    ����������mdlOutputs
    ���߶��ڱ����ʱ���mdlGetTimeOfNextVarHit������u�ĺ�����
    ��ģ�����ֱ����ͨ������sizes.DirFeedthrough=1;����Ϊ0��
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
