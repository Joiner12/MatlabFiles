%{
    ����˵��:
    @funcname:TDA(΢�ָ�����)
    1.�Ӵ��������ź�����ȡ���߻ظ�ԭʼ�źţ��Եõ�ԭʼ�źŵ���ѱƽ�;
    2.������������ߴ�����������������ź���ȡԭʼ�źż�΢���ź�����;
    3.΢�ָ��������������ۺϺ�����
    4.����΢�ָ�����
    5.��ȡԭʼ�ź�һ���źţ���Ϊ����΢��-������ǰ��������

    @param:p1 �Ӻ���fst_m��r,�������ٿ���
    @param:p2 �Ӻ���fst_m��h0,���������˲�ЧӦ
    @param:p3 ǰ������ϵ����alpha
    @param:u ��������ź�
    @param:t ��������

    [1]����ǿ, ������. TD�˲�������Ӧ��[J]. ���㼼�����Զ���, 2003, 22(s1):61-63.
    [2]������΢�����ĵ�Ч���Է������Ż���
%}
function [sys,x0,str,ts] = TDB(t,x,u,flag,p1,p2,p3)

switch flag
    
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
        
    case 2
        sys = mdlUpdate(t,x,u,p1,p2,p3);
        
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
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0,0];
str = [];
ts  = [1e-3 0];
% end mdlInitializeSizes

% ==========================================================================
function sys = mdlUpdate(~,x,u,p1,p2,p3)
T = 1e-3;
vt = u(1);
v1 = u(2);
h0 = p1*T;
r = p2;
alpha_forward = p3;

x(1) = x(1) + T*x(2);
x(2) = x(2) + T*fst_m(vt,x(1),x(2),r,h0) + alpha_forward*v1;

sys = [x(1),x(2)];

% ==========================================================================
function sys = mdlOutputs(~,x,~)
sys = x;