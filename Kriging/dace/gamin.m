function [theta f fit perf] = gamin(lob, upb, par)
% ʹ���Ŵ��㷨�Ż�theta

nvars=length(lob); % ��Ʊ�������
popsize=60; % ��Ⱥ��
maxgen=300; % ������
tolfun1=1e-9;

% Start with the default options
options = gaoptimset;
% Modify options setting
options = gaoptimset(options,'PopulationSize',popsize);

options = gaoptimset(options,'Generations', maxgen);

options = gaoptimset(options,'TolFun',tolfun1);
[theta, f]=ga(@funobj,nvars,[],[],[],[],lob,upb,[],options);
f
% Ϊ�˴���Fixed Variables(par),����Nested Functions
    function obj=funobj(theta_ttt)
        obj = objfunc(theta_ttt, par);
    end

[f, fit] = objfunc(theta, par);

perf = struct('perf',[theta'; f'; 1]);

end