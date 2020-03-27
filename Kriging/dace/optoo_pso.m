function [opt,point]=optoo(data)
global dmodel1;
theta = [1 1 1 1 1 1 1 1 1 1 1]*2;
lob = [1e-10 1e-10 1e-10 1e-10 1e-10 1e-10 1e-10 1e-10 1e-10 1e-10 1e-10];
upb = [40 40 40 40 40 40 40 40 40 40 40];
stroke=data(:,12);
force=data(:,13);
S=data(:,1:11);
[dmodel1, perf1] =dacefit(S, stroke, @regpoly2, @corrgauss, theta, lob, upb,6);
x0=[8659973,2.422,31415.9,24053,25446,395,1.06,0.89,27377.1498,474.6,0];
diff=[86599.73 0.02 100 100 100 10 0.05 0.02 100 10 2];
lob1=x0-diff;
upb1=x0+diff;
options = psooptimset('Algorithm', 'active-set');
options.ConstrBoundary='absorb';
options.PlotFcns = {@psoplotbestf} ;
Options.LargeScale='on';
Options.StallGenLimit=300;
hybridopts = optimset('Algorithm','sqp');
 options = psooptimset(options,'HybridFcn', { @fmincon ,hybridopts }); 
[x,fval,exitflag,output]=pso(@objfun,11,[],[],[],[],lob1,upb1,@const,options)
opt=fval;
point=x;
end

function objfun=objfun(x)
x0=[8659973,2.422,31415.9,24053,25446,395,1.06,0.89,27377.1498,474.6,0];
diff=[86599.73 0.02 100 100 100 10 0.05 0.02 100 10 2];
y=(x-x0)./diff;
objfun=(y*y')^0.5;
end
function [c,ceq]=const(x)
global dmodel1;
ceq=predictor(x,dmodel1)-310;
c=[];
end

