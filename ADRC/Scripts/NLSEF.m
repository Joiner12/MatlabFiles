%{
    Nonlinear State Error Feedback(NLSEF)
    second order
    
    Basic formula:
    &U_0 = b_1fal(\epsilon_1,\alpha_1,\delta) + b_2fal(\epsilon_2,\alpha_2,\delta)\\
    &\epsilon_1 = e_1 - z_1\\
    &\epsilon_2 = e_2 - z_2\\
   
    Parameter:
    alpha:�����Զ�
    delta:����������
    bt:״̬ϵ��

    Reference:
    [1]I:\�ڿ�����\2019��6��9��\������״̬���������ɩ���NLSEF.pdf
%}


% Part(ii) s-function
%{
    ���ÿ���������
%}
function [sys,x0,str,ts] = NLSEF(t,x,u,flag,alpha_1,delta_1,bt1,alpha_2,delta_2,bt2)
switch flag

    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;

    case 2
        sys = mdlUpdate(t,x,u,flag,alpha_1,delta_1,bt1,alpha_2,delta_2,bt2);

    case 3
        sys = mdlOutputs(t,x,u);

    case {1,4}
        if false
            sys = mdlGetTimeOfNextVarHit(t,x,u);
        else
            % sys = [];
        end

    case 9
        sys = mdlTerminate(t,x,u);

    otherwise
        DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end


function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 2;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

% initialize the initial conditions
x0  = [0 0];

str = [];
% initialize the array of sample times
ts  = [1e-3 0];

% simStateCompliance = 'UnknownSimState';

%=============================================================================
% mdlUpdate
function sys = mdlUpdate(t,x,u,flag,alpha_1,delta_1,bt1,alpha_2,delta_2,bt2)
uz = zeros(1,2);
se = zeros(1,2);
se(1) = u(1);
se(2) = u(2);

uz(1) = bt1*Fal_Func(se(1),alpha_1,delta_1);
uz(2) = bt2*Fal_Func(se(2),alpha_2,delta_2);

x = uz;
sys = x;

%=============================================================================
% mdlOutputs

function sys = mdlOutputs(t,x,u)
sys = sum(x);


%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
function sys = mdlTerminate(t,x,u)
sys = [];