%% 
% Created date : 2019年7月17日
clc;
disp('ADRC Block ')
PurposePath = 'D:\Codes\MatlabFiles\ADRC';
if ~strcmp(PurposePath,pwd)
    cd D:\Codes\MatlabFiles\ADRC
end
fprintf('load path...\n%s\n',pwd)
clear ans
%%
% 测试函数
%{
    设计思路：
    1.微分-跟踪器 ： 提取微分信号，跟踪系统输入；
    2.@parameter:h:积分步长，r决定跟踪快慢；
    3.微分跟踪器同低通滤波器，KF性能对比；
    4.参数调整说明：
        h 是积分步长，r 是决定跟踪快慢的参数。r 越大，x1更快地 跟踪信号 v，
        但当 v 被噪声污染时，会使信号 x1被更大的噪 声所污染。
        为了滤掉 x1 所含的噪声，选取适当的 h1，能获 得很好的滤波效果。然而，
        h1 越大，就会使 x1 跟踪信号 v 的相位损失也越大。 
    Reference:
    [1]韩京清，武利强，TD滤波器及其应用
    [2]张海丽，张宏立，微分跟踪器的研究与应用，化工自动化及仪表，
        2013，40（04），474-477
%}
clc;
fprintf("微分-跟踪器测试\n");
t = zeros(0);
ts = 1e-3;              % 采样周期

% 仿真信号
signal_fre = 10; % hz'
signal_amp = 1;

% 正弦信号 + 随机噪声
v = zeros(0);
diff_theroyvalue = zeros(0);
time = zeros(0);
x1 = zeros(0);
x2 = zeros(0);
lpx1 = zeros(0);
lpx2 = zeros(0);
v_dis = 0;

% 仿真时间
simutime = 2;   % s
h1 = ts ; r = 1000;
for i = 1:1:simutime/ts
    v_cur = signal_amp*sin(2*pi*signal_fre*i*ts);
    if mod(i,20) == 0
        v_dis = (rand - 0.5)*signal_amp/10 ;
    end
    v_cur = v_cur + v_dis;
    time(i) = i*ts;
    v(i) = v_cur;
    if isequal(i,1)
        x1(i) = 0;
        x2(i) = 0;
        diff_temp = v_cur/ts;
    else
        [x1(i),x2(i)]  = TDR1(x1(i-1),x2(i-1),...
            v_cur,h1,r);
        diff_temp = (v(i) - v(i-1))/ts;
    end
    diff_theroyvalue(i) = diff_temp;
    
    % 局部一阶低通滤波
    if isequal(i,1)
        lpx1(i) = 0;
        lpx2(i) = 0;
    else
        lp_cof = 0.4;
        lpx1(i) = v_cur*lp_cof + lpx1(i-1)*(1 - lp_cof);
        lpx2(i) = (lpx1(i) - lpx1(i-1))/ts;
    end
    
end
% figure
close all;
figure(1)
subplot(2,2,1)
plot(time,v,time,x1,time,x2,time,diff_theroyvalue)
legend('输入信号','跟踪信号','微分信号','理论查分值')
set(get(gca, 'XLabel'), 'String', 't/m');
set(get(gca, 'YLabel'), 'String', 'height/mm');

subplot(2,2,2)
plot(time,lpx1,time,x1)
legend('低通','微分跟踪器x1')

subplot(2,2,3)
plot(time,lpx2,time,x2*80)
legend('低通','微分跟踪器x2')
%% 函数模块
%{
    @param:
    {
        x1_k1 = x1(k+1);        (1) 跟踪信号
        x2_k1 = x2(k+1);        (2) 跟踪微分信号
        x1_k = x1(k);           (3)
        x2_k = x2(k);           (4)
        v_k = v(k);             (5) 原始信号
        y_k = y(k);             (6)
        h;                      (7) 积分步长
        r;                      (8) 速度因子
    }
    涉及到微分相关参数初始化需要在函数外部完成；
    
%}
function [x1_k1,x2_k1] = TDR1(x1_k,x2_k,v_k,h1,r)
    d = h1*r;
    d1 = h1*d;
    % e(k) = x1(k) - v(k)                   (1)
    ek = x1_k - v_k;

    % y(k) = e(k) + h1*x2(k)                (2)
    y_k = ek + h1*x2_k;
    % g(k)                                  (3)
    gk_funout = gk_fun(x2_k,y_k,h1,r,d);

    %------------------fst(.)--------------------%
    fst_out = -r*SatV2(gk_funout,d);
    
    % 
    x1_k1 = x1_k + h1*x2_k;
    x2_k1 = x2_k + h1*fst_out;
end 

%------------------g(k)--------------------%
%{
    参数：
    r                                   (1) 速度因子
    h1                                  (2) 滤波因子   
    公式：
    d = h1*r                            (1) 
    d1 = h1*d                           (2)
    e(k) = x1(k) - v(k)                 (3)
    y(k) = e(k) + h1*x2(k)              (4)
%}
function y = gk_fun(x2_k,y_k,h1,r,d)
    d1 = h1*d;
    ret_temp = 0;
    if abs(y_k) >= d1
        ret_temp = x2_k + sign(y_k)*(sqrt(8*r*abs(y_k)+d^2) -d)/2;
    else
        ret_temp = x2_k + y_k/h1;
    end
    y = ret_temp;
end


%------------------sat(.)--------------------%
%{ 
    SISO饱和函数
%}
function y = SatV1(x,delta,paraflag)
    if delta < 0
        delta = 0;
    end

    if paraflag
        fprintf("饱和函数参数δ:%d\n",delta);
    end

    if abs(x) >= delta
        y_temp = sign(x);
    else
        y_temp = x./delta;
    end
    y = y_temp;
end


%------------------sat(.)version2--------------------%
%{ 
    SISO饱和函数
%}
function y = SatV2(x,delta)
    if delta < 0
        delta = 0;
    end

    if abs(x) >= delta
        y_temp = sign(x);
    else
        y_temp = x./delta;
    end
    y = y_temp;
end
