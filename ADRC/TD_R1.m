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
%{
    设计思路：
    1.微分-跟踪器 ： 提取微分信号，跟踪系统输入；
    2.@parameter:h:积分步长，r决定跟踪快慢；
    3.微分跟踪器同低通滤波器，KF性能对比；
    Reference:[1]韩京清，武利强，TD滤波器及其应用
%}

clc;
x = linspace(-10,10,100);
y = zeros(0);
for i=1:1:length(x)
    y(i)=Sat(x(i),5,true);
end

figure
line(x,y)

%------------------fst(.)--------------------%
function yf = fst(x,delta)
    yf = 0;
    
end


%------------------sat(.)--------------------%
% SISO饱和函数
function y = Sat(x,delta,paraflag)
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

