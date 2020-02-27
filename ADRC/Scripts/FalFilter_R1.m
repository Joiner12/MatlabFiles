%% path
clc;clear;
CurPath = pwd;
% if CurPath == TargetPath
if strcmp(CurPath,'D:\Codes\MatlabFiles\ADRC\Scripts')
    fprintf('Path...%s\t\n%s\n',pwd,'ADRC');
else
    cd H:\MatlabFiles\ADRC\Scripts
end
clear ans CurPath TargetPath

%% 
%{
    fal滤波器
    1.reference：《基于fat函数滤波的改进自抗扰技术的实现》.吕永佳
    2.Fal滤波器性能探究;
    3.调用H:\MatlabFiles\ADRC\Fal_Func函数: y = Fal_Func(e,alpha,delta)
    4.结论
    alpha，delta，kFal,参数对于不同的频率设计而言，不同;
%}
clc;
disp('Fal filter simuilator')
SampFre = 1000; % 采样频率
SgnFre = 1;    % 信号频率
SgnLength = 5000;   % 信号长度
SgnAmp = 1;     % 信号幅值
para_alpha = 0.5;
para_delta = 0.01*SgnAmp;
para_k = 20;
t = linspace(1,SgnLength,SgnLength)/SampFre;

Sgn = SgnAmp*sin(2*pi*SgnFre.*t);
%  white gausian noise
Noise_rand = (rand(1,SgnLength) - 0.5)/5;
Noise_wg = 0.1*wgn(1,SgnLength,1);
SgnNoise = SgnAmp*sin(2*pi*SgnFre.*t) + Noise_rand ;%
flt_out = zeros(0);
Sum_out = zeros(0);
Lp_out = zeros(0);

%----------------Fal滤波器----------------%
for i = linspace(1,SgnLength,SgnLength)
    if i <= 1
        e = SgnNoise(i);
    else
        e = SgnNoise(i) - Sum_out(i-1);
    end
   
    flt_out(i) =  para_k*Fal_Func(e,para_alpha,para_delta);
    Sum_out(i) = sum(flt_out(1:i))/SampFre;
end

%----------------低通滤波器----------------%
Cof_Lp = 0.2;
for k = linspace(1,SgnLength,SgnLength)
    if Cof_Lp > 1
        error('低通滤波系数错误')
    end
    if k > 1
        Lp_out(k) = Cof_Lp*SgnNoise(k) + (1 - Cof_Lp)*Lp_out(k-1);
    else
        Lp_out(k) = SgnNoise(k);
    end
end

%----------------figure----------------%
close all
figure
subplot(2,2,1)
plot(t,Sgn,'b')
hold on 
plot(t,SgnNoise,'c')
hold on
plot(t,Sum_out,'r')
grid minor
legend('理想信号','噪声信号','滤波输出')

subplot(2,2,2)
plot(flt_out)
grid minor

subplot(2,2,3)
plot(t,Sgn,'b')
hold on 
plot(t,Lp_out,'c')
hold on
plot(t,Sum_out,'r')
grid minor
% para_alpha = 0.5;
% para_delta = 0.01*SgnAmp;
% para_k = 20;
paras = strcat('alpha:',num2str(para_alpha),...
    'delta:',num2str(para_delta),'k',num2str(para_k));
text(0,1,paras)
legend('理想信号','低通滤波','fal滤波')

%% 
%{
    设计思路：
    1.输入外部信号;
    2.测试外部信号作用下，低通和Fal滤波器的效果;
%}
t1 = tic;
clc;
disp('对现有采集数据进行滤波效果对比')

%----------------参数设置----------------%
Outer_Sgn = Outer(352:end);
SampFre = 500; % 采样频率
SgnLength = length(Outer_Sgn);

% 预分配内存
FalOut_01 = zeros(0);
LpOut_01 = zeros(0);
SumOut_01 = zeros(0);
time_01 = linspace(1,SgnLength,SgnLength)/SampFre;

% fal滤波器参数设置
para_alpha = 0.5;
para_delta = 5000;
para_k = 2000;

% 低通滤波器参数设置
Cof_Lp = 0.2;
disp('Calculating...')
%----------------滤波----------------%
for i = linspace(1,SgnLength,SgnLength)
    % fal滤波器
    % 需要处理初始条件
    if i <= 1
        e = 0;
        SumOut_01(i) = Outer_Sgn(i);
        FalOut_01(i) = Outer_Sgn(i);
    else
        e = Outer_Sgn(i) - SumOut_01(i-1);
        FalOut_01(i) =  para_k*Fal_Func(e,para_alpha,para_delta);
        SumOut_01(i) = sum(FalOut_01(1:i))/SampFre;
    end
    % 低通滤波器
    k = i;
    if Cof_Lp > 1
        error('低通滤波系数错误')
    end
    if k > 1
        LpOut_01(k) = Cof_Lp*Outer_Sgn(k) + (1 - Cof_Lp)*LpOut_01(k-1);
    else
        LpOut_01(k) = Outer_Sgn(k);
    end
end

%----------------绘图----------------%
disp('Figures drawing...')
p1 = figure;
p1.Name = 'FAL&Lp';
% subplot(2,2,1)
plot(Outer_Sgn)
hold on
plot(LpOut_01)
hold on 
plot(SumOut_01)
legend('原始信号','低通滤波','fal滤波')
grid minor
toc(t1)
