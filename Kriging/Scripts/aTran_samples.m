clc;
clear;

% 正态分布系数
Para1 = [0.05,0.043,0.035,0.032,1,1000,2E11];
Cof_1 = 0.0045;
Para2 = Cof_1.*Para1;

% Para1 = [0.05,0.043,0.035,0.032,1,1000,2E11];
% Para2 = 0.0045*[0.05,0.043,0.035,0.032,1,1000,2E11];

% 正态分布
distribution = {'norm','norm','norm','norm','norm','norm','norm'};

%
Nx = length(Para1);
Nt = 100012;  


%{
        生成采样序列函数:sobol
        matlab自带函数:sobol
        matlab 命令窗口输入查看该函数具体定义和用法:
        >> docsearch sobol 
%}
Dp = sobolset(Nx,'Skip',1e3,'Leap',1e2);

for i=1:Nx
    
    %{
        分布函数:icdf
        matlab自带函数:icdf
        matlab 命令窗口输入查看该函数具体定义和用法:
        >> docsearch icdf 
    %}
    Xt(:,i) = icdf(distribution{i},Dp(1:Nt,i),Para1(i),Para2(i));
end
count = 0;

% 模型函数
%{
    y = (4*x(:,6).*x(:,5).^3)./(x(:,7).*(x(:,3).*x(:,1).^3 - x(:,4).*x(:,2).^3));
%}
[y] = g(Xt);

%数据拆分： Xt数组第1行到第12行数据
s = Xt(1:12,:);
%数据拆分： Xt数组第13行到第最后一行数据
ss = Xt(13:end,:);

ys = y(1:12,:);
yss = y(13:end,:);

% 数组y的平均值
%{ 
    matlab自带函数：mean
    matlab 命令窗口输入查看该函数具体定义和用法:
    >> docsearch mean 
    
%}
mean_y = mean(y);


return;
save s.mat s;
save ys.mat ys;
save ss.mat ss;
save yss.mat yss;
save mean_y.mat mean_y;


fprintf("命令行输入，然后回车\n");