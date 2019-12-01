%% Path
clc;
if ~isqual('H:\MatlabFiles\ADRC\Scripts',pwd)
    cd H:\MatlabFiles\ADRC\Scripts
end
fprintf('load path...\n%s\n',pwd);

%% Arrange Transient Process
%{
    1. s域和t域
    S域：v1(T,s) = (1-e^(T*s/2))^2/((T/2)^2*s^2)
    
    t域：
    tms(T,t) = 2*t^2/T^2, (0=< t <T/2);
    tms(T,t) = (t^2 - 2(t-T/t)^2)*2/(T^2),(T/2 <= t <T);
    tms(T,t) = 1,t >= T;

    Reference:
    [1]I:\期刊文献\2019年2月25日\安排过渡过程是提高闭环系统“鲁棒性、适应性和稳定性”的一种有效方法.pdf
%}
clc;
s = tf('s');
T = 1E-3;

gca_legend = {};
if true
    close all
    
    figure(2)
    xlim([0,1]);
    cnt = 1;
    for i = 400:400:4000
        % atp tf1
        hold on
        T1 = i*T;
        V_1S = (((1 - exp(-T1*s/2)))^2)/((T1/2)^2)/s^2;
        %         tf_ob = (16.75)/(s^2 + 10*s);
        tf_ob = feedback(1/(s^2 + s),1);
        
        atpsys = tf_ob*V_1S;
        step(atpsys)
        
        gca_legend{cnt} = num2str(i);
        cnt = cnt + 1;
        
        %         pause(0.5)
        drawnow
    end
    set(get(gca,'Legend'),'string', gca_legend);
end


%% s域和t域 
clc;
fprintf('t域 .vs. s域\n');
ts = 1E-3;
time = ts.*linspace(0,2000,200);
cof =  zeros(0);
T2 = 100*ts;
for i = 1:1:length(time)
    tick = time(i);
    if tick < T2/2
        cof(i) = 2*(tick^2)/(T2^2);
    elseif tick >= T2
        cof(i) = 1;
    else
        cof(i) = (tick^2 - 2*(tick-T2/2)^2)*2/(T2^2);
    end
end
figure
plot(time,cof)

%% delay system
clc;
tic;
fprintf('delay block\n');
s = tf('s');
T = 1E-3;
T1 = 10*T;
delaySys = (((1 - exp(-T1*s/2)))^2)/((T1/2)^2)/s^2;
[num,den] = tfdata(c2d(delaySys,T,'zoh'),'v');
tfdata(c2d(delaySys,T,'zoh'),'v')
toc