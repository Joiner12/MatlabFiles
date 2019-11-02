function [NONE] = RealTimeFft(fs,sound)
    static player
    player = 0;
    if player == 0
        player = 1;
    end
    % initializ variables
    SampleFre = fs; % Sample frequency
    Origin = sound; % Origin datas

    if ((SampleFre <= 0) || (isempty(Origin)))
       warning('Error occurs in origin data')
       return
    end

    
    Fs = SampleFre;            % Sampling frequency                    
    T = 1/Fs;             % Sampling period       
    L = 1500;             % Length of signal
    Y = fft(X);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
    plot(f,P1) 
    title('Single-Sided Amplitude Spectrum of X(t)')
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
    

end


