%{
    2019��10��14��
    When asked about,I can't remember how it works;
%}
N=8;                         %ԭ��ɢ�ź���8��
n=[0:1:N-1]                  %ԭ�ź���1��8�еľ���
xn=0.5.^n;                   %����ԭʼ�źţ�Ϊָ���ź�
w=[-8:1:8]*4*pi/8;           %Ƶ��-800----+800 �ĳ��ȣ���Ӧ�������Ƶ�������٣���ʡȥ��
X=xn*exp(-1j*(n'*w));         %��dtft�任������ԭʼ����ķ������Ը�ָ��������Ͷ���
subplot(211)
stem(n,xn);
w1=[-4:1:4]*4*pi/4;
X1=xn*exp(-1j*(n'*w1));
title('ԭʼ�ź�(ָ���ź�)');
subplot(212);
stem(w/pi,abs(X));
title('ԭ�źŵ�16��DFT�任')
subplot(213)
stem(w1/pi,abs(X1));
title('ԭ�źŵ�8��DFT�任')


%% Version 0.2
% �����һ��������δ������г���Ϊɶdftͼ���fftͼ��һ��
clc;
close all
t1 = tic;
N=1000;
n=(0:1:N-1);
xn=0.5.^n;

w = (-8:1:8)*4*pi/8;
X = xn*exp(-1j*(n'*w));
figure;
subplot(211)
stem(n,xn);
title('ԭʼ�ź�(ָ���ź�)');
subplot(212);
stem(w/pi,abs(X));
title('DFT�任')
toc(t1)

t2 = tic;
figure;
N=1000;
n = (0:1:N-1);
xn=0.5.^n;
Xk = fft(xn,16);
subplot(221);
stem(n,xn);
title('ԭ�ź�');
subplot(212);
stem(linspace(-pi,pi,16),abs(Xk));
title('FFT�任')
toc(t2)