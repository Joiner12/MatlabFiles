%% path
clc;clear;
TargetPath = 'H:\MatlabFiles\ChildBlocks';
CurPath = pwd;
% if CurPath == TargetPath
if strcmp(CurPath,TargetPath)
    fprintf('Road...%s\t\n%s\n',pwd,'ChildBlocks');
    
else
    cd H:\MatlabFiles\ChildBlocks
end
clear ans CurPath TargetPath

%% 
% gotData = txtscan('%f,%f','C:\Users\Whtest\Desktop\FFT\Datas\TestData.txt')
figure
fre = TestData(:,1);
amp = TestData(:,2);
f1 = bar(fre.Variables,amp.Variables);
grid on

%%
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 511;             % Length of signal
t = (0:L-1)*T;        % Time vector
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
X = S + 2*randn(size(t));
Y = fft(TestData1.Variables);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
bar(f,P1) 
hold on 
f1 = bar(fre.Variables,amp.Variables);
title('Single-Sided Amplitude Spectrum of X(t)')
legend('matlab','c')
grid on
xlabel('f (Hz)')
ylabel('|P1(f)|')