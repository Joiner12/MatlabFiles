clc;
clear;
if ~isequal('D:\Codes\MatlabFiles\Blocks',pwd)
    cd('D:\Codes\MatlabFiles\Blocks')
    fprintf('Reload path: %s\n',pwd);
end

%% 
clc;
clear;
file1 = 'C:\Users\10520\Desktop\MarkPride.wav';
file = 'C:\Users\10520\Desktop\river flows in you.wav';
[audio,fs] = audioread(file1);
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
flowLeft = audioplayer(left_channle,fs);
flowRight = audioplayer(right_channle,fs);
flowFull = audioplayer(audio,fs);
% play(flowLeft)
% play(flowRight)
pause(1)
play(flowFull)
if false
figure(1)
    clc;
    clf;
    box on;
    grid minor
    % xlim([0,300])
    ylim([-100,100])
    h = animatedline;
    for i = 1:1000:flowFull.TotalSamples
        addpoints(h,i/flowFull.SampleRate,100*left_channle(i));
        h.Color = 'red';
        h.LineWidth = 1.5;
        drawnow
        pause(1000/flowFull.SampleRate);
    end
end
% plot(left_channle)
% realFigure(flowLeft.TotalSamples,left_channle,flowLeft.SampleRate);
figure(2)
comet(linspace(1,flowFull.TotalSamples,flowFull.TotalSamples),...
    right_channle,0.9)
%%
% stop(flowLeft)
% stop(flowRight)
stop(flowFull)
%% 
clc;
realFigure(flowLeft.TotalSamples,left_channle,flowLeft.SampleRate)
%% functions
function realFigure(sample,src,samplerate)
    close all
    figure;
    subplot(2,1,1);
    xlim([-1,1]);
    ylim([-1,1]);
    axis([-1 1 -1 1]);
    axis equal;
    rectangle('position',[-0.5,-0.5,1,1],'curvature',[1,1]);
    hold on
    
    subplot(2,1,2);
    h = animatedline;
    pointLst = 0;
    for i = 1:100:sample
        pointCur = src(i);
        p1 = plot(pointLst*2,pointCur*2);
        p1.Marker = '*';
        p1.MarkerSize = 5;
        pointLst = pointCur;
        pause(100/samplerate)
        hold on
        if int32(mod(i,10000)/10000) == 0
            cla;
%             clf;
        end
        
        addpoints(h,i/samplerate,pointCur)
        hold on
        drawnow
    end
end
%{
    Reference:
    [1]https://blog.csdn.net/u010480899/article/details/78234884¶¯Ì¬Í¼
%}


 