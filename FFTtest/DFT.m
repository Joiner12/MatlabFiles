%{
    2019��10��14��
    When asked about,I can't remember how it works;
%}
%% DFT
clc;
fprintf('Discrete Fourier Transform\n');
N1 = 8; % ���г���
SreialNums = 0:1:N1-1;
xn = 0.5.^SreialNums;
DFTN8 = zeros(0); % 8�㸵��Ҷ�任
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
title('��ɢ����')
subplot(312)
stem(linspace(0,2*pi,N1),abs(DFTN8))
xlabel('\omega')
ylabel('|A(X)|')
title('8��DFT')
