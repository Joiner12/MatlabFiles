function [theta f fit perf] = gamin(lob, upb, par)
% 使用遗传算法优化theta

nvars=length(lob); % 设计变量个数
popsize=60; % 种群数
maxgen=300; % 最大代数
tolfun1=1e-9;

% Start with the default options
options = gaoptimset;
% Modify options setting
options = gaoptimset(options,'PopulationSize',popsize);

options = gaoptimset(options,'Generations', maxgen);

options = gaoptimset(options,'TolFun',tolfun1);
[theta, f]=ga(@funobj,nvars,[],[],[],[],lob,upb,[],options);
f
% 为了传递Fixed Variables(par),创建Nested Functions
    function obj=funobj(theta_ttt)
        obj = objfunc(theta_ttt, par);
    end

[f, fit] = objfunc(theta, par);

perf = struct('perf',[theta'; f'; 1]);

end