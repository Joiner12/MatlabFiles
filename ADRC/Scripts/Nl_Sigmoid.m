%%
disp('load path...')
ScriptPath = 'H:\MatlabFiles\Vibrate\scripts';
cd(ScriptPath)
%-------------控制系统相关-------------%
% SIGMOID函数导致系统振荡加剧的原因
% 偏差函数为什么可以降低系统的振荡
% SIGMOID函数变换对应关系
%
%% 
%------------sigmoid 函数测试<一>--------------%
% 
error_3 = linspace(-10,10,100);
[cof_3,out_3] = sigmoid(error_3);

figure
subplot(2,1,1)
plot(error_3,cof_3)
subplot(2,1,2)
plot(error_3,error_3)
hold on 
plot(error_3,out_3)
legend('origin','origin-cof')


%%
%------------sigmoid 函数测试<二>--------------%
clc;
x = linspace(-10,10,100);

figure
for i=0:0.2:2
    [cof_ans,out_ans] = sigmoid_01(x,i,0,1);
    subplot(2,1,1)
    plot(x,cof_ans)
    hold on 
    grid on

    subplot(2,1,2)
    plot(x,out_ans)
    hold on 
    grid on
    pause(0.1)
end

legend(num2str(linspace(0,2,11))')

%%
%------------离散sigmoid函数测试<三>--------------%
% 生成数组
[sig_cof,out] = sigmoid(linspace(-10,10,20));
sig_cof
figure
plot(linspace(-10,10,20),sig_cof)

%% sigmoid 函数
% f(x) = 1/(1+e^(-x))
function [cof,out] = sigmoid(error)
    cof = zeros(0);
    out = zeros(0);
    for i=1:1:length(error)
        cof(i) = 1/(1+exp(-(error(i))));
        out(i) = cof(i)*error(i);
    end
end

%------------alfa θ sigmoid核函数--------------%
% sig(x,alfa,θ) = amp*(1 + exp(-alfa*(x + θ)))^-1
% alfa：增益，决定变化速率，θ：偏移量，amp:放大倍率
function [cof,out] = sigmoid_01(x,alfa,xita,amp)
    cof = zeros(0);
    out = zeros(0);
    x_len = length(x);
    if x_len < 1
        disp(['x',',参数错误']);
        return;
    end

    for i=1:1:x_len
        x_temp = x(i);
        cof_temp = (1 + exp(-alfa*(x_temp - xita)));
        cof_temp = power(cof_temp,-1);
        cof_temp = cof_temp*amp;
        cof(i) = cof_temp;
    end

    % 输出结果
    out = cof.*x;
end

