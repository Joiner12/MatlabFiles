%{
    ����˵��:
    @funcname:ELTD_F(��Ч����΢�ָ�����+ǰ������)
    1.��̬�㸽������̩��չ��������ͬ�����Ժ������е�Ч������
    2.�ó���ͬ�����Ժ����ĵ�Ч����ģ��,ͨ����ͬ�������þ�������΢�ָ�������ʽ��
    3.��չ����΢�ָ�����������ǰ������ԭ�������λ�


    @param:R
    @param:k1
    @param:k2
    @param:u [��������ź�,ǰ��������]
    @param:t ��������
    
    ������ϵ��
    s = tf('s');
    gs = @(R,k1,k2,s) (k1*R^2/(s^2 + k2*R*s + k1*R^2))

    [1]����ǿ, ������. TD�˲�������Ӧ��[J]. ���㼼�����Զ���, 2003, 22(s1):61-63.
    [2]������΢�����ĵ�Ч���Է������Ż���
    [3]������΢���������Ч���Է�����
    [4]��ǰ�򡢺����ּ�����ʽŷ�����̡�https://blog.csdn.net/wu_nan_nan/article/details/53173302
    [5]������΢�������о���Ӧ�á�
%}
function [sys,x0,str,ts] = ELTD_F(t,x,u,flag,k1,k2,R,ForCof)

switch flag
    
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
        
    case 2
        sys = mdlUpdate(t,x,u,k1,k2,R,ForCof);
        
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
sizes.NumOutputs     = 2;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0,0,0];
str = [];
u = [0,0];
ts  = [5e-4 0];
% end mdlInitializeSizes

% ==========================================================================
function sys = mdlUpdate(~,x,u,k1,k2,R,ForCof)
T = 5e-4;
vt = u(1);
v_f = u(2);

%{
    % ����ģʽ��֤�������demux mux����
    models = ["debug","forward","general"];

    model = models(1);
    switch model
        case "forward"

        case "general"

        case "debug"

    end
%}
forwardComp = true;
if forwardComp
    % ��ǰ������
    alpha_f = ForCof;
    x(1) = x(1) + T*x(2);
    
    err_1 = x(1) - vt; % x1(k) - v(k)
    % alpha_f:ǰ��ϵ��
    x(2) = x(2) + T*(-k1*err_1 - k2*x(2)/R)*R^2  + alpha_f*(v_f - x(3));
    x(3) = v_f;
    % x(2) = x(2) + T*(-k1*err_1 - k2*x(2)/R)*R^2 + R*v1;
else
    %{
        ��ɢ���ʽ: x2(k) = x2(k-1) + R^2*(-k1*(x1(k) - v(k)) -k2*x2(k)/R)*T;
        ����ǰ��������ʽ��״̬��������2
    %}
    x(1) = x(1) + T*x(2);
    err_1 = x(1) - vt; % x1(k) - v(k)
    x(2) = x(2) + T*(-k1*err_1 - k2*x(2)/R)*R^2;
    x(3) = 0;
end

sys = [x(1),x(2),x(3)];

% ==========================================================================
function sys = mdlOutputs(~,x,~)
sys = [x(1),x(2)];