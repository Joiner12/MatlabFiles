function [theta f fit perf] = pso1min(lob, upb, par)
% ʹ������Ⱥ���Ż�theta
% x = pso(fitnessfcn,nvars,Aineq,bineq,Aeq,beq,LB,UB,nonlcon,options)
addpath .\psopt
nvars=length(lob);
maxgen=300;
popsize=100;
tolfun1=1e-9;
PopInitRange=[lob;upb];
% Start with the default options
options = psooptimset;
% Modify options setting
options = psooptimset(options,'Generations', maxgen);
options = psooptimset(options,'PopulationSize', popsize);
options = psooptimset(options,'TolFun', tolfun1);
options = gaoptimset(options,'PopInitRange', PopInitRange);


hybridopts = optimset('TolFun',tolfun2,'TolX',tolx);
options = psooptimset(options,'HybridFcn', {  @fminunc ,hybridopts}); % ʹ�û���㷨

[theta, f, exitflag, output]=ga(@funobj,nvars,[],[],[],[],lob,upb,[],options);
% Ϊ�˴���Fixed Variables(par),����Nested Functions
    function obj=funobj(theta_ttt)
        obj = objfunc(theta_ttt, par);
    end

[f, fit] = objfunc(theta, par);

perf = struct('perf',[theta'; f; 1],'exitflag',exitflag, 'output',output);

end