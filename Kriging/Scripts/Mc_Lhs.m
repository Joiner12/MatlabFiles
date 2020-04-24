% ����̬����˹���ֲ��ı���������������������
% Ч�����ã����Զ����м���
clc;clear;close all
%���þ�ֵ�ͷ����������
Mu=[3.6e7;3.6e7]; %��ֵ
Sigma=[3.6e6,3.6e6]; %����
N = 30; % ��������Ŀ
D = size(Mu,1); % ά��
Covariance_Matrix = zeros(D,D);
for i = 1:D
    Covariance_Matrix(i,i) = Sigma(i)^2;
end
 
UB = Mu + 3*Sigma;
LB = Mu - 3*Sigma; % ȡֵ��Χ
 
X = lhsnorm(Mu, Covariance_Matrix, N);
%  X = lhsnorm(Mu, Sigma, N);
figure(1)
plot(X(:,1),X(:,2),'*');grid on
title('��̬�ֲ���LHS����')

%% 
clc;close all; clearvars;
%   ������̬�ֲ��Ĳ�������
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
if dist(j)==3  %������̬�ֲ�
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
  title('������̬�ֲ���LHS����')
elseif n==3
  figure
  plot3(S(:,1),S(:,2),S(:,3),'lc.');grid on
end

%% ��άMonte Carlo
clc;close all;
% [-1,1]���������ֲ�-���Ӹ�˹�ֲ���ά�ռ�(x,y)Э����Ϊ��
[x,y]= meshgrid(linspace(-1,1,5));
z = rand(size(y)).*rand(size(x));
figure
mesh(x,y,z)
