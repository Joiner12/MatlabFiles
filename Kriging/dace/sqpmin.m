function [theta f fit perf] =samin(theta0, lob, upb, par)
MaxFunEvals=10000;
MaxIter=400;
TolX=1e-10;
TolFun=1e-10;
options=optimset('MaxFunEvals',MaxFunEvals,'MaxIter',MaxIter,'TolX',TolX,'TolFun',TolFun);
options=optimset(options,'Algorithm','SQP',...
'GradObj','off','GradConstr','off','FinDiffType', 'central');
[theta,f,exitflag,output]=fmincon(@funobj,theta0,[],[],[],[],lob,upb,[],options);
f
    function obj=funobj(theta_ttt)
        obj = objfunc(theta_ttt, par);
    end

[f, fit] = objfunc(theta, par);

perf = struct('perf',[theta'; f; 1],'exitflag',exitflag, 'output',output);

end