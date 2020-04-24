% 对正态（高斯）分布的变量进行拉丁超立方采样
% 效果不好，可以多运行几次
clc;clear;close all
%设置均值和方差，采样点数
Mu=[3.6e7;3.6e7]; %均值
Sigma=[3.6e6,3.6e6]; %方差
N = 30; % 样本点数目
D = size(Mu,1); % 维数
Covariance_Matrix = zeros(D,D);
for i = 1:D
    Covariance_Matrix(i,i) = Sigma(i)^2;
end
 
UB = Mu + 3*Sigma;
LB = Mu - 3*Sigma; % 取值范围
 
X = lhsnorm(Mu, Covariance_Matrix, N);
%  X = lhsnorm(Mu, Sigma, N);
figure(1)
plot(X(:,1),X(:,2),'*');grid on
title('正态分布的LHS采样')

%% 
clc;close all; clearvars;
%   对数正态分布的参数设置
    m=20;dist=[3,3];
    mu=[3.6e7,1.98e8];
    sigma=[3.6e6,9.9e6];
    lowb=[mu-3*sigma];
    upb=[mu+3*sigma];

n=length(mu);
if length(dist)~=n|length(sigma)~=n|length(lowb)~=n|length(upb)~=n
    error('dist,mu,sigma,lowb,upb must have the same length');
end
rvcom=[];
for j=1:n
    rv=[];
if dist(j)==3  %对数正态分布
    p_low(j)=logncdf(lowb(j),mu(j),sigma(j));
    p_up(j)=logncdf(upb(j),mu(j),sigma(j));
    p_bound(j)=p_up(j)-p_low(j);
    p_subbound(j)=p_bound(j)./(m-1);
      for i=0:m-1
        rv=[rv;logninv(p_low(j)+i.*p_subbound(j),mu(j),sigma(j))];
      end
elseif dist(j)==4 %for extreme type 1
    p_low(j)=evcdf(lowb(j),mu(j),sigma(j));
    p_up(j)=evcdf(upb(j),mu(j),sigma(j));
    p_bound(j)=p_up(j)-p_low(j);
    p_subbound(j)=p_bound(j)./(m-1);
    for i=0:m-1
       rv=[rv;evinv(p_low(j)+i.*p_subbound(j),mu(j),sigma(j))];
    end
end
rvcom=[rvcom rv];
end
S=[];
for i=1:n
    S=[S randsample(rvcom(:,i),m)];
end
if n==2
  figure
  plot(S(:,1),S(:,2),'r*');grid on
  title('对数正态分布的LHS采样')
elseif n==3
  figure
  plot3(S(:,1),S(:,2),S(:,3),'lc.');grid on
end

%% 二维Monte Carlo
clc;close all;
% [-1,1]区间的随机分布-服从高斯分布二维空间(x,y)协方差为零
[x,y]= meshgrid(linspace(-1,1,5));
z = rand(size(y)).*rand(size(x));
figure
mesh(x,y,z)
