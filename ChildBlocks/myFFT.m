function [ ] = myFFT(x , T)
    
%     T = T;  %采样周期
    Fs = 1/T;  %采样频率
    % NormalData = NormalData-1.23e6;
    Len = length(x); %数据长度
    t_n = (0:Len-1)*T;  % 时域

    Y_N = fft(x,Len); %傅里叶变换
    Y_N_2 = abs(Y_N/Len);
    YN_y = Y_N_2(1:Len/2+1);
    Fre_x= Fs*(0:(Len/2))/Len;

    figure
    suptitle('FFT')
    subplot(2,1,1)
    plot(Fre_x,YN_y)
    title('Single-Sided Amplitude Spectrum of Data(t)')
    xlabel('f (Hz)')
    ylabel('|Amplitude(f)|')
    grid on
    subplot(2,1,2)
    plot(t_n,x)
    title('origin data')
    grid on
end