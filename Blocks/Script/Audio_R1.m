
clc;
clear;
if ~isequal('D:\Codes\MatlabFiles\Blocks',pwd)
    cd('D:\Codes\MatlabFiles\Blocks')
    fprintf('Reload path: %s\n',pwd);
end

%%
clc;
file_pride = 'C:\Users\10520\Desktop\MarkPride.wav';
file_speed = 'C:\Users\10520\Desktop\speed.wav';

[audio,fs] = audioread(file_speed);

left_channle = audio(:,1);
right_channle = audio(:,2);

if false
    figure
    subplot(211)
    plot(left_channle)
    grid minor
    
    subplot(212)
    plot(right_channle/4)
    grid minor
end

%%
clc;
flowLeft = audioplayer(leftOut,fs);
flowRight = audioplayer(right_channle,fs);
audio_remix = [leftOut,right_channle];
flowFull = audioplayer(audio_remix,fs);
% play(flowLeft)
% play(flowRight)
play(flowFull)
file_speedremix = 'C:\Users\10520\Desktop\speedRemix.flac';
audiowrite(file_speedremix,audio_remix,fs)
%%
% stop(flowLeft)
% stop(flowRight)
stop(flowFull)

%%
% ========================================================================
%{
    ï¿½ï¿½Í¨ï¿½Ë²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
%}
clc;
channlesize = length(left_channle);
leftOut = zeros(channlesize,1);
rightOut = zeros(channlesize,1);
for i = 1:1:channlesize
    if i < 5
        leftOut(i) = left_channle(i);
        rightOut(i) = right_channle(i);
    else
        % filtercof.mat direct II low pass IIR filter coficient
        if true
            leftOut(i) = Num(1)*left_channle(i) + Num(2)*left_channle(i-1)...
                + Num(3)*left_channle(i-2)...
                + Num(4)*left_channle(i-3) ...
                -((Den(1)*leftOut(i-1)) + (Den(2)*leftOut(i-2)+ Den(3)*leftOut(i-3)));
            
            if leftOut(i) > 100 && false
                fprintf('%d\n',i);
            end
            
        end
        
        if false
            lowpassCof = 0.1;
            leftOut(i) = lowpassCof*left_channle(i) + (1-lowpassCof)*leftOut(i-1);
            lowpassCof = 0.1;
            
            rightOut(i) = lowpassCof*right_channle(i) + (1-lowpassCof)*rightOut(i-1);
        end
    end
end
%%
figure
plot(leftOut(1:end))
hold on
plot(left_channle(1:end))
legend('filter','bbefo')
grid minor


%%
% ========================================================================
%{
    Block:Music Visualizer
    1.ÒôÀÖ¿ÉÊÓ»¯
%}
% load file...
clc;
close all ;
clear;
filepath = 'C:\Users\10520\Desktop';
filename = 'David Guetta,Sam Martin - Lovers On The Sun (Radio Edit).mp3';
file = fullfile(filepath,filename);
[audioFile,fs] = audioread(file);
fftSrc = audioFile(:,1);
audioSun = audioplayer(audioFile,fs);
%%
systick = tic;

figure
gap = 1000;
close all;
clf;
% ½¨Á¢figure
for i = 1:1:int32(length(fftSrc)/gap)
    if i == 1
        play(audioSun);
    end
    tail = i*gap;
    head = (i - 1)*gap + 1;
    fprintf('toc:%d\n',toc(systick));
    pause(gap*0.8/fs);
    ax1 = subplot(211);
    cla;
    [fre,amp] = myFFT(fftSrc(head:tail),fs);
    areAX = area(ax1,fre(20:1:end),amp(20:1:end));
    areAX.FaceColor =  [0 0.75 0.75];
    areAX.EdgeColor = 'green';
    hold on
    baAx = bar(ax1,fre(20:1:end),-amp(20:1:end));

    xlim([800 fs/4]);
    ylim([-15 15]);
    
    ax2 = subplot(212);
    cla;
    plot(ax2,fftSrc(head:tail))
    ylim([-2,2])
    hold on 
  
    drawnow;
end

% ========================================================================
%% 
stop(audioSun)
close all;
clc;
% ========================================================================
%{
    fft
    reference:matlab doc
%}
function [Fre,Amp] = myFFT(src,fs)
srclen = length(src);
y = fft(src);
P2 = 200*abs(y/srclen);
P1 = P2(1:int32(srclen/2+1));
P1(2:end-1) = P1(2:end-1);
Amp = P1;
f = fs*(0:(srclen/2))/srclen;
Fre = f';
end
