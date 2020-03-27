function [theta f fit perf] =samin(theta0, lob, upb, par)
% ʹ��ģ���˻��㷨�õ�theta
% [x fval] = simulannealbnd(@objfun,x0,lb,ub,options)
tolfun1=1e-9;
tolfun2=1e-9;
tolx=1e-9;
initemperature=100; % ��ʼ�¶�
reannealinter=200;
% Start with the default options
options = saoptimset;
% Modify options setting
options = saoptimset(options,'TolFun', tolfun1);
hybridopts = optimset('Algorithm','sqp','TolFun',tolfun2,'TolX',tolx);
% ʹ�û���㷨,��ʹ��fminuncʱ��'TolFun'�޷��޸ģ�ԭ��δ֪
options = saoptimset(options,'HybridFcn', {  @fmincon ,hybridopts }); 
options = saoptimset(options,'HybridInterval', 'end');
options = saoptimset(options,'ReannealInterval', reannealinter);
%options = saoptimset(options,'PlotFcns', { @saplotbestf });
options = saoptimset(options,'InitialTemperature', initemperature);
options.MaxFunEvals=8000
[theta,f,exitflag,output] = simulannealbnd(@funobj,theta0,lob,upb,options);
f
% Ϊ�˴���Fixed Variables(par),����Nested Functions
    function obj=funobj(theta_ttt)
        obj = objfunc(theta_ttt, par);
    end

[f, fit] = objfunc(theta, par);

perf = struct('perf',[theta'; f; 1],'exitflag',exitflag, 'output',output);

end