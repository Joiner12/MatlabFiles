%% 
% 巴特沃斯低通滤波器设计 
wp=2*pi*4000;                       %通带边界角频率
ws=2*pi*5000;                       %阻带边界角频率
Rp=1;                               %通带最大衰减
Rs=15;                              %阻带最小衰减
fs = 1000;
[NN,Wn]=buttord(wp,ws,Rp,Rs,'s');   %选择滤波器的最小阶数
[Z,P,K]=buttap(NN);                 %创建butterworth模拟滤波器
[Bap,Aap]=zp2tf(Z,P,K);
[b,a]=lp2lp(Bap,Aap,Wn);   
[bz,az]=bilinear(b,a,fs);          %用双线性变换法实现模拟滤波器到数字滤波器的转换

[H,W]=freqz(bz,az);                %绘制频率响应曲线
figure(4);
plot(W*fs/(2*pi),abs(H));
grid;
xlabel('频率／Hz');
ylabel('频率响应幅度');
title('Butterworth');


%% 一阶，二阶低通滤波器频域响应对比图
clc;close all;clear;
disp(' 一阶，二阶低通滤波器频域响应对比图')
H_1 = tf(1,[1,10]);
H_2 = tf(1,[1,1,10]);

figure
bode(H_1)
hold on 
bode(H_2)
grid on 
title('一阶，二阶低通滤波器频域响应对比图')
legend('one degree','second degree')