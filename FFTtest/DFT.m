%{
    2019年10月14日
    When asked about,I can't remember how it works;
%}
%% DFT
clc;
fprintf('Discrete Fourier Transform\n');
N1 = 8; % 序列长度
SreialNums = 0:1:N1-1;
xn = 0.5.^SreialNums;
DFTN8 = zeros(0); % 8点傅里叶变换
for k = 1:1:N1
	% WN = exp(-j*n*2*pi/N1)
	temp = -1j*2*pi/N1;
	DFTN8(k) = sum(xn.*exp(temp*k.*SreialNums));
end

close all
figure(1)
subplot(311)
stem(SreialNums,xn)
xlabel('n')
title('离散序列')
subplot(312)
stem(linspace(0,2*pi,N1),abs(DFTN8))
xlabel('\omega')
ylabel('|A(X)|')
title('8点DFT')
