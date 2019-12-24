%{
    simulator of ecg
    1.刷新Figure图窗实现ECG
    
%}
function ECG()
clc;
try
    close('ecg');
catch
end
shg
clf reset

set(gcf,'color','white','menubar','none', ...
   'numbertitle','off','name','ecg')
% plot(0,0,'.','markersize',4);
xlim([0 10]);
axis off;
hold on ;
stop = uicontrol('style','toggle','string','stop', ...
   'background','white');
drawnow;
cnt = 1;
a = tic;
while ~get(stop,'value')
    b = toc(a);
    % 刷新时间间隔
    if b > 1 || isequal(cnt,1)
        cla;axis off;hold on;
        drawnow;
        cnt = cnt + 1;
        fprintf('called:%.0f\n',cnt);
        CometRate();
        hold on;
        drawnow;
        a = tic;
    end
end
fprintf('finished\n')
end

%% 生成不同心率ECG数据

function [x,ecg] = GenerateData(rate)
x=0.01:0.01:10;
if rate > 200
    rate = 200;
end
li=30/rate;

a_pwav=0.25;
d_pwav=0.09;
t_pwav=0.16;

a_qwav=0.025;
d_qwav=0.066;
t_qwav=0.166;

a_qrswav=1.6;
d_qrswav=0.11;

a_swav=0.25;
d_swav=0.066;
t_swav=0.09;

a_twav=0.35;
d_twav=0.142;
t_twav=0.2;

a_uwav=0.035;
d_uwav=0.0476;
t_uwav=0.433;
pwav=p_wav(x,a_pwav,d_pwav,t_pwav,li);


%qwav output
qwav=q_wav(x,a_qwav,d_qwav,t_qwav,li);


%qrswav output
qrswav=qrs_wav(x,a_qrswav,d_qrswav,li);

%swav output
swav=s_wav(x,a_swav,d_swav,t_swav,li);


%twav output
twav=t_wav(x,a_twav,d_twav,t_twav,li);


%uwav output
uwav=u_wav(x,a_uwav,d_uwav,t_uwav,li);

%ecg output
ecg=pwav+qrswav+twav+swav+qwav+uwav;


end


%% comet function call 
function x = CometRate()
[t,x] = GenerateData(rand*10 + 10);
comet(t,x)
end
