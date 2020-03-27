function [opt,point]=optoo(data)
global dmodel2;
global fid;
theta = [1 1 1 1 1 1 1 1 1 1 1];
lob = [1e-10 1e-10 1e-10 1e-10 1e-10 1e-10 1e-10 1e-10 1e-10 1e-10 1e-10];
upb = [40 40 40 40 40 40 40 40 40 40 40];
stroke=data(:,12);
force=data(:,13);
S=data(:,1:11);
%[dmodel1, perf1] =dacefit(S, stroke, @regpoly2, @corrgauss, theta, lob, upb,6);
[dmodel2, perf2] =dacefit(S, force, @regpoly2, @corrgauss, theta, lob, upb,4);
x0=[8659973,2.422,31415.9,24053,25446,395,1.06,0.89,27377.1498,474.6,0];
diff=[86599.73 0.02 100 100 100 10 0.05 0.02 100 10 2];
lob1=x0-diff;
upb1=x0+diff;
popsize=200; % 种群数
maxgen=200; % 最大代数
tolfun1=1e-9;
tolfun2=1e-9;
tolx=1e-11;
maxfunevals=5000;
PopInitRange=[lob;upb];
% Start with the default options
options = gaoptimset;
% Modify options setting

options = gaoptimset(options,'PopulationType', 'doubleVector');
options = gaoptimset(options,'PopulationSize',popsize);
options = gaoptimset(options,'CreationFcn', @gacreationuniform);
options = gaoptimset(options,'FitnessScalingFcn', @fitscalingrank);
options = gaoptimset(options,'SelectionFcn', @selectionstochunif);
options = gaoptimset(options,'PopInitRange', PopInitRange);
% options = gaoptimset(options,'MutationFcn', @mutationgaussian);
options = gaoptimset(options,'Generations', maxgen);
hybridopts = optimset('TolFun',tolfun2,'TolX',tolx,'MaxFunEvals',maxfunevals,'Algorithm','SQP');
options = gaoptimset(options,'HybridFcn', {  @fmincon ,hybridopts}); % 使用混合算法
options = gaoptimset(options,'PlotFcns', { @gaplotbestf});
options = gaoptimset(options,'TolFun',tolfun1);
fid=fopen('data.txt','w');
[x,fval,exitflag,output]=ga(@objfun,11,[],[],[],[],lob1,upb1,@const,options);
fclose(fid);
opt=fval;
point=x;
end

function objfun=objfun(x)
global fid;
x0=[8659973,2.422,31415.9,24053,25446,395,1.06,0.89,27377.1498,474.6,0];
diff=[86599.73 0.02 100 100 100 10 0.05 0.02 100 10 2];
y=(x-x0)./diff;
objfun=(y*y')^0.5;
fprintf(fid,'%.4f\n',objfun);
end
function [c,ceq]=const(x)
global dmodel2;
ceq=500000-predictor(x,dmodel2);
c=[];
end

