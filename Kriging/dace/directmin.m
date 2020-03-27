function [theta f fit perf] =directmin(lob, upb, par)
   bounds = [lob',upb'];
    options.ep=1e-6;
    options.testflag  = 0;
    options.maxevals=4000;
    options.maxits=10000;
    options.showits =1;
    options.maxdeep=1000;
    Problem.f = @funobj;
    [f,theta] = Direct(Problem,bounds,options)
    
    function obj=funobj(theta_ttt)
        obj = objfunc(theta_ttt, par);
    end

[f, fit] = objfunc(theta, par);

perf = struct('perf',[theta; f; 1]);

end