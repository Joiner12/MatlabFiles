%% 常用信号生成
%{
    生成典型的信号序列 

    ref:
    [1] 常用序列的MATLAB实现 https://blog.csdn.net/zhengqijun_/article/details/53265625
   
%}
clc;
fprintf('Just for test\n');
[x,y]=stepseq(20,0,1000);
figure
plot(x)

%% 1. 单位采样序列
function[x,n] = impseq(n0,ns,nf)
% ns=序列的起点；nf=序列的终点；n0=序列在n0处有一个单位脉冲。
% x=产生的单位采样序列；n=产生序列的位置信息
n = [ns:nf];
x = [(n-n0)==0];
end

%% 2. 单位阶跃序列
% ns=序列的起点；nf=序列的终点
% n0=从n0处开始生成单位阶跃序列
% x=产生的单位阶跃序列； n=产生序列的位置信息
function[x,n] = stepseq(n0,ns,nf)
n = [ns:nf];
x = 10.*[(n-n0)>=0];
end


%% 3. 矩形序列
function[x,n] = rectseq(n0,ns,nf,N)
% ns=序列的起点；nf=序列的终点；n0=矩形序列开始的位置
% N=矩形序列的长度；x=产生的矩形序列；n=产生序列的位置信息
n = [ns:nf];
x = [(n - n0) >= 0 & ((n0 + N - 1) - n) >= 0];
end


%% 4. 实指数序列
function[x,n] = realindex(ns,nf,a)
% ns=序列的起点；nf=序列的终点；n0=实指数的值
% x=产生的实指数序列；n=产生序列的位置信息
n = [ns:nf];
x = a.^n;
end

%% 5. 正弦序列
function[x,n] = sinseq(ns,nf,A,w0,alpha)
% ns=序列的起点；nf=序列的终点；A=正弦序列的幅度
% w0=正弦序列的频率；alpha=正弦序列的初始相位
% x=产生的正弦序列；n=产生序列的位置信息
n = [ns:nf];
x = A * sin(w0 * n + alpha);
end
%% 6. 复指数序列
function[x,n] = complexindex(ns,nf,index)
% ns=序列的起点；nf=序列的终点；index=复指数的值
% x=产生的复指数序列；n=产生序列的位置信息
n = [ns:nf];
x = exp(index.*n);
end