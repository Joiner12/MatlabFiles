function S=lhsamp(m,n,distribution_type,option)

% Latin hypercube sampling
% m: 抽样次数
% n：变量维数
% distribution_type：变量分布特征，可选项：'uniform','normal','lognormal','weibull','beta'
%                   distribution_type为cell类型(n*q)，如{'uniform',0,1;'normal',0,1}
%                   每一行分别表示所对应的变量的分布类型,及相关参数：
%                   {'uniform',a,b}
%                   {'normal',mu,sigma}
%                   {'lognormal',mu,sigma}
%                   {'weibull',a,b}
%                   {'beta',a,b}
%                   {'exponential',mu,pcov,alpha}
% option：选项
%       option.fun：可选项：1：1（使用lhsdesign函数）:2：其他值(不使用lhsdesign函数)
%       option.criterion：详见lhsdesign函数的帮助'criterion'
%       option.iterations：详见lhsdesign函数的帮助'iterations'
%
% Syntax: 
%       S=lhsamp;
%       S=lhsamp(m);
%       S=lhsamp(m,n);
%       S=lhsamp(m,n,distribution_type);
%       S=lhsamp(m,n,distribution_type,option);
%
% example1: 两相互独立[0,1]均匀分布变量，抽样10次
%       option.fun=1;
%       option.criterion='maximin';
%       option.iterations=1000;
%       S = lhsamp(10,2,{'uniform',0,1;'uniform',0,1},option);
%       figure;plot(S(:,1),S(:,2)','+')
%       grid on
%       figure;hist(S(:,1),0.05:0.1:1);
%       figure;hist(S(:,2),0.05:0.1:1);
% example2: 一[0,1]均匀分布变量与一标准正态分布变量相互独立，抽样666次
%       option.fun=1;
%       option.criterion='maximin';
%       option.iterations=1000;
%       S = lhsamp(666,2,{'uniform',0,1;'normal',0,1},option);
%       figure;plot(S(:,1),S(:,2)','+')
%       grid on
%       figure;hist(S(:,1));
%       figure;hist(S(:,2));
%
% 参考文献：1 Michael Stein,1987,Large Sample Properties of Simulations Using Latin Hypercube Sampling 
%          2 matlab帮助,lhsdesign函数

if nargin < 1
    m = 1;
end
if nargin < 2
    n = m;
end
if nargin < 3
    distribution_type=repmat({'uniform',0,1},n,1);
end
if nargin < 4
    option.fun=1;
    option.criterion='maximin';
    option.iterations=1000;
end

% 检查变量维数是否与distribution_type一致
L_distribution_type=size(distribution_type,1);
if n~=L_distribution_type
    error('变量维数与变量类型数目不一致');
end

S = zeros(m,n);
if option.fun==1
    S=lhsdesign(m,n,'criterion',option.criterion,'iterations',option.iterations);
else
    for k= 1 : n
        S(:, k) = (rand(1, m) + (randperm(m) - 1))' / m;
    end
end

for k=1:L_distribution_type
    switch distribution_type{k,1}
        case 'uniform'
            S(:,k)=unifinv(S(:,k),distribution_type{k,2},distribution_type{k,3});
        case 'normal'
            S(:,k)=norminv(S(:,k),distribution_type{k,2},distribution_type{k,3});
        case 'lognormal'
            S(:,k)=logninv(S(:,k),distribution_type{k,2},distribution_type{k,3});
        case 'weibull'
            S(:,k)=wblinv(S(:,k),distribution_type{k,2},distribution_type{k,3});
        case 'beta'
            S(:,k)=betainv(S(:,k),distribution_type{k,2},distribution_type{k,3});
        case 'exponential'
            S(:,k)=expinv(S(:,k),distribution_type{k,2});
        otherwise
            error('不支持%s分布，需要添加该分布',distribution_type{k,1});
    end
end
