%%
disp('load path...')
ScriptPath = 'H:\MatlabFiles\Vibrate\scripts';
cd(ScriptPath)
%-------------����ϵͳ���-------------%
% SIGMOID��������ϵͳ�񵴼Ӿ��ԭ��
% ƫ���Ϊʲô���Խ���ϵͳ����
% SIGMOID�����任��Ӧ��ϵ
%
%% 
%------------sigmoid ��������<һ>--------------%
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
%------------sigmoid ��������<��>--------------%
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
%------------��ɢsigmoid��������<��>--------------%
% ��������
[sig_cof,out] = sigmoid(linspace(-10,10,20));
sig_cof
figure
plot(linspace(-10,10,20),sig_cof)

%% sigmoid ����
% f(x) = 1/(1+e^(-x))
function [cof,out] = sigmoid(error)
    cof = zeros(0);
    out = zeros(0);
    for i=1:1:length(error)
        cof(i) = 1/(1+exp(-(error(i))));
        out(i) = cof(i)*error(i);
    end
end

%------------alfa �� sigmoid�˺���--------------%
% sig(x,alfa,��) = amp*(1 + exp(-alfa*(x + ��)))^-1
% alfa�����棬�����仯���ʣ��ȣ�ƫ������amp:�Ŵ���
function [cof,out] = sigmoid_01(x,alfa,xita,amp)
    cof = zeros(0);
    out = zeros(0);
    x_len = length(x);
    if x_len < 1
        disp(['x',',��������']);
        return;
    end

    for i=1:1:x_len
        x_temp = x(i);
        cof_temp = (1 + exp(-alfa*(x_temp - xita)));
        cof_temp = power(cof_temp,-1);
        cof_temp = cof_temp*amp;
        cof(i) = cof_temp;
    end

    % ������
    out = cof.*x;
end

