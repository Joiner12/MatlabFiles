%% Second Order System Anlysis
%{
    跟踪微分器等效线性-二阶系统分析

    reference:
    [1]https://zhuanlan.zhihu.com/p/45493939
    [2]D:\DTs\跟踪微分器的等效线性分析及优化.pdf
%}
clc;
s = tf('s');
omega = 60;
epsilon = 1;
sec_sys = omega^2/(s^2 + 2*omega*epsilon*s + omega^2);

try
    close('bode_sec')
catch
    
end

fig1 = figure;
fig1.Name = 'bode_sec';
fig1.NumberTitle = 'off';
legs = {};
cnt = 1;
para_TD = [52,0.9;60,1;78,0.3;45,0.4];
%{
for epsilon_i = 0.1:0.4:0.9
    for omega_j = 40:40:40
        sec_sys01 = omega_j^2/(s^2 + 2*omega_j*epsilon_i*s + omega_j^2);
        legs{cnt} = strcat(num2str(epsilon_i),'|',num2str(omega_j));
        cnt = cnt + 1;
        bode(sec_sys01);
        hold on
        drawnow
    end
end
%}

for i = 1:1:4
    omega_j = para_TD(i,1);
    epsilon_i  = para_TD(i,2);
    sec_sys01 = omega_j^2/(s^2 + 2*omega_j*epsilon_i*s + omega_j^2);
    legs{cnt} = strcat(num2str(epsilon_i),'|',num2str(omega_j));
    cnt = cnt + 1;
    bode(sec_sys01);
    hold on
    drawnow
end

legend(legs)
grid minor

%% 
clc;clear;
% xita = 0:0.01*pi:2*pi;
xita = 2*pi.*rand(1,400);
x1 = sin(xita);
y1 = cos(xita);
z1 = (sin(xita) + 2.*cos(xita)).*xita;
x1 = wgn(1000,1,0);
y1 = wgn(1000,1,0);
z1 = wgn(1000,1,0);

try
    close('se')
catch
end
fig2 = figure();
fig2.Name = 'se';
scatter3(x1,y1,z1,'filled')
% scatter3(xita,xita,xita,'filled')
grid minor
hold on 
[x1,y1,z1]  = ellipsoid(0,0,0,2,2,2);
surf(x1,y1,z1) %　画出来球



