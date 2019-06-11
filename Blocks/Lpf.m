%% 
% ������˹��ͨ�˲������ 
wp=2*pi*4000;                       %ͨ���߽��Ƶ��
ws=2*pi*5000;                       %����߽��Ƶ��
Rp=1;                               %ͨ�����˥��
Rs=15;                              %�����С˥��
fs = 1000;
[NN,Wn]=buttord(wp,ws,Rp,Rs,'s');   %ѡ���˲�������С����
[Z,P,K]=buttap(NN);                 %����butterworthģ���˲���
[Bap,Aap]=zp2tf(Z,P,K);
[b,a]=lp2lp(Bap,Aap,Wn);   
[bz,az]=bilinear(b,a,fs);          %��˫���Ա任��ʵ��ģ���˲����������˲�����ת��

[H,W]=freqz(bz,az);                %����Ƶ����Ӧ����
figure(4);
plot(W*fs/(2*pi),abs(H));
grid;
xlabel('Ƶ�ʣ�Hz');
ylabel('Ƶ����Ӧ����');
title('Butterworth');


%% һ�ף����׵�ͨ�˲���Ƶ����Ӧ�Ա�ͼ
clc;close all;clear;
disp(' һ�ף����׵�ͨ�˲���Ƶ����Ӧ�Ա�ͼ')
H_1 = tf(1,[1,10]);
H_2 = tf(1,[1,1,10]);

figure
bode(H_1)
hold on 
bode(H_2)
grid on 
title('һ�ף����׵�ͨ�˲���Ƶ����Ӧ�Ա�ͼ')
legend('one degree','second degree')