%% 
% Created date : 2019年7月17日
clc;
disp('ADRC Block ')
PurposePath = 'D:\Codes\MatlabFiles\ADRC';
if ~strcmp(PurposePath,pwd)
    cd D:\Codes\MatlabFiles\ADRC
end
fprintf('load path\t>>>>\t%s\n',pwd)
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
    Reference:[1]韩京清，武利强，TD滤波器及其应用
%}

fprintf("微分-跟踪器测试\n");
clc;
% clear;
t = linspace(0,199,200); % s
signal_fre = 10; % hz'
sample_fre = 0.01; %hz'
v = 10*sin(2*pi*signal_fre.*t) + (rand(1,200).*2 - 1);
OptCnt = 0;
x1 = zeros(200,1);
x2 = zeros(200,1);
diff_theroyvalue = 10*cos(2*pi*signal_fre.*t);
h1 = 0.1 ; r = 400;
while OptCnt < length(t)
    OptCnt = OptCnt + 1;
    if OptCnt > 1
        [x1(OptCnt),x2(OptCnt)]  = TDR1(x1(OptCnt-1),x2(OptCnt-1),...
        v(OptCnt - 1),h1,r);
    end
end

% figure
close all;
figure(1)
plot(v)
hold on 
plot(x1)
hold on 
plot(x2)
hold on 
plot(diff_theroyvalue)
legend('原始','跟踪信号','微分信号','理论微分值')

%% 函数模块
%{
    @param:{
        x1_k1 = x1(k+1);        (1)
        x2_k1 = x2(k+1);        (2)
        x1_k = x1(k);           (3)
        x2_k = x2(k);           (4)
        v_k = v(k);             (5)
        y_k = y(k);             (6)
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
