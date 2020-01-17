clc;clear;
CurPath = pwd;
% if CurPath == TargetPath
if strcmp(CurPath,'H:\MatlabFiles\ADRC\Scripts')
    fprintf('Path...%s\t\n%s\n',pwd,'ADRC');
else
    cd H:\MatlabFiles\ADRC\Scripts
end
clear ans CurPath TargetPath
%% load H:\MatlabFiles\ADRC\Scripts\sstep.mat
%{
    sstep.mat真实的阶跃信号
%}
load('H:\MatlabFiles\ADRC\Scripts\sstep.mat');

%%
%{
    系统模型(i)
    From input "u1" to output "y1":
        16.75 (+/- 0.2556) s - 0.2331 (+/- 1.816)
    --------------------------------------------------
    s^2 + 0.3274 (+/- 0.1804) s + 0.06028 (+/- 0.3627)
    
    控制对象输入 (-2^-15 ~ 2^15) digital
    控制对象输出 1P - 0.001mm

%}
clc;
T = 5e-4;
s = tf('s');
tf_ob = (16.75)/(s + 0.5);
if true
    sys = ss(tf_ob)
    [num,den] = tfdata(c2d(tf_ob,T*2,'zoh'),'v')
    % transfer function to space state
else
    [A,B,C,D] = tf2ss([0 0 16.7],[1 0.5 0])
end


%%
%{
    系统模型(ii)
    Gp(s) = 0.00011167(s + 33006)/(s^2 + 1.245s)
    reference:
    [1]王永强，张承瑞，滚珠丝杠进给系统仿真建模，振动与冲击，2013，32（03），46-49
%}
clc;
clearvars -except sstep
T = 1e-3;
s = tf('s');
Gs = 0.00011167*(s + 33006)/(s*s + 1.245*s)
% Gs = 100/(s+1)
[num,den] = tfdata(c2d(Gs,T,'tustin'),'v')
if false
    figure(1)
    step(feedback(Gs,1))
end

%% State Space  System Model
%{
    系统二阶状态，x'2 = sign(sin(0.05t)) + (1.5 + 0.5sign(sin(0.03t)cos(0.02t)))
    reference:
    [1]I:\电子书\控制工程\自抗扰控制技术-估计补偿不确定因素的控制技术.pdf page.205
%}
clc;
fprintf('state space second order function...\n');
ssf1 = @(t) sign(sin(0.05.*t)) + (cos(0.02.*t)).*(0.5.*sign(sin(0.03.*t)) + 1.5);

ts = 10;
tick = ts.*linspace(1,1000,1000);
ssfy = ssf1(tick);
figure
shg
plot(tick,ssfy)

%%
%{
    System Model(iii)
    典型二阶系统
    Specific:
    reference：《自动控制原理》page.79-81
%}
clc;
fprintf('system model ver3\n');
s = tf('s');
ts = 5e-4;
omega = 100;
ipselong = 0.2;
Gs = omega^2/(s^2 + 2*omega*ipselong*s);
DisGs = c2d(Gs,ts);
[num,den] = tfdata(DisGs,'v')


if false
    figure(1)
    % step(Gs)
    %     step(feedback(Gs,1))
    bode(feedback(Gs,1))
end

%% get system transfer data
clc;
fprintf('system model ver4—first order inertial\n');
s = tf('s');
ts = 1e-3;
sysys = 'IDS';
switch sysys
    case 'IDS'
        fprintf('IDS\n');
        tfSysIner = (16.75*s + 1)/(s^2 + 0.327*s + 0.06);
        DisTfSysIner = c2d(tfSysIner,ts,'z')
        [num,den] = tfdata(DisTfSysIner,'v')
    case 'FOIS'
        fprintf('FOIS\n');
        tao = 10;
        Gs = 1/(tao*ts*s + 1)/s;
        dsys = c2d(Gs,ts,'z')
        [num,den] = tfdata(dsys,'v');
        sysys = 'IDS';
    otherwise
        fprintf('OTHER CASE\n');
        tao = 10;
        Gs = 1/(tao*ts*s + 1)/s;
        dsys = c2d(Gs,ts,'z')
        [num,den] = tfdata(dsys,'v');
        sysys = 'IDS';
        
end

% 验证线性时不变离散系统
return;

y = zeros(0);
u = zeros(0);
time = zeros(0);
cmp = 1;
switch cmp
    %{
        验证离散卷积
    %}
    case 1
        for i = 1:8e4
            % y(k) = 1000*u(k) - 10*y(k-1)/-9
            u(i) = 1;
            time(i) = i*ts;
            if i==1
                y(i) = 0;
            else
                %                 y(i) = 0.0001*u(i-1) + 0.9999*y(i-1);
                y(i) = 0.1*u(i-1) + 0.9*y(i-1);
            end
        end
        figure(1)
        subplot(211)
        plot(time,y)
        hold on
        plot(time,u)
        subplot(212)
        step(dsys)
    case 2
        %{
            系统辨识结果：
            y(k) = -den(2)*y_1 - den(3)*y_2 + num(2)*u_1 + num(3)*u_2 [1];
            
        %}
        % y(k) = -0.99y(k-1) + u(k-1) + u(k)
        if i  < 2
            y(i) = 2;
        else
            
        end
    otherwise
        figure('name','first order')
        step(Gs)
        grid minor
        
end

