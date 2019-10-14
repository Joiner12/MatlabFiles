%{
    2019年10月14日
    When asked about,I can't remember how it works;
%}
N=8;                         %原离散信号有8点
n=[0:1:N-1]                  %原信号是1行8列的矩阵
xn=0.5.^n;                   %构建原始信号，为指数信号
w=[-8:1:8]*4*pi/8;           %频域共-800----+800 的长度（本应是无穷，高频分量很少，故省去）    
X=xn*exp(-1j*(n'*w));         %求dtft变换，采用原始定义的方法，对复指数分量求和而得
subplot(311)
stem(n,xn);
w1=[-4:1:4]*4*pi/4;
X1=xn*exp(-1j*(n'*w1));
title('原始信号(指数信号)');
subplot(312);
stem(w/pi,abs(X));
title('原信号的16点DFT变换')
subplot(313)
stem(w1/pi,abs(X1));
title('原信号的8点DFT变换')