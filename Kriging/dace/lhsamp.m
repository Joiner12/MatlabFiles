function S=lhsamp(m,n,distribution_type,option)

% Latin hypercube sampling
% m: ��������
% n������ά��
% distribution_type�������ֲ���������ѡ�'uniform','normal','lognormal','weibull','beta'
%                   distribution_typeΪcell����(n*q)����{'uniform',0,1;'normal',0,1}
%                   ÿһ�зֱ��ʾ����Ӧ�ı����ķֲ�����,����ز�����
%                   {'uniform',a,b}
%                   {'normal',mu,sigma}
%                   {'lognormal',mu,sigma}
%                   {'weibull',a,b}
%                   {'beta',a,b}
%                   {'exponential',mu,pcov,alpha}
% option��ѡ��
%       option.fun����ѡ�1��1��ʹ��lhsdesign������:2������ֵ(��ʹ��lhsdesign����)
%       option.criterion�����lhsdesign�����İ���'criterion'
%       option.iterations�����lhsdesign�����İ���'iterations'
%
% Syntax: 
%       S=lhsamp;
%       S=lhsamp(m);
%       S=lhsamp(m,n);
%       S=lhsamp(m,n,distribution_type);
%       S=lhsamp(m,n,distribution_type,option);
%
% example1: ���໥����[0,1]���ȷֲ�����������10��
%       option.fun=1;
%       option.criterion='maximin';
%       option.iterations=1000;
%       S = lhsamp(10,2,{'uniform',0,1;'uniform',0,1},option);
%       figure;plot(S(:,1),S(:,2)','+')
%       grid on
%       figure;hist(S(:,1),0.05:0.1:1);
%       figure;hist(S(:,2),0.05:0.1:1);
% example2: һ[0,1]���ȷֲ�������һ��׼��̬�ֲ������໥����������666��
%       option.fun=1;
%       option.criterion='maximin';
%       option.iterations=1000;
%       S = lhsamp(666,2,{'uniform',0,1;'normal',0,1},option);
%       figure;plot(S(:,1),S(:,2)','+')
%       grid on
%       figure;hist(S(:,1));
%       figure;hist(S(:,2));
%
% �ο����ף�1 Michael Stein,1987,Large Sample Properties of Simulations Using Latin Hypercube Sampling 
%          2 matlab����,lhsdesign����

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

% ������ά���Ƿ���distribution_typeһ��
L_distribution_type=size(distribution_type,1);
if n~=L_distribution_type
    error('����ά�������������Ŀ��һ��');
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
            error('��֧��%s�ֲ�����Ҫ��Ӹ÷ֲ�',distribution_type{k,1});
    end
end
