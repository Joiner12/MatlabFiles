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
    ��ͨ�˲�������
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
