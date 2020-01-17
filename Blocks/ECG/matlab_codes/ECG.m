function ECG()
%{
        simulator of ecg
        1.data from complete;
        2.draw a figure fresh 0.01 seonds
%}
clc;
shg
clf reset

try
    close('ecgfig');
catch
    %     ...
end

% datas
tick = 10;
fprintf('simulator of ecg,simulating duration:%.0f seconds.\n',tick);
t = linspace(0.01,tick,int32(tick/0.01));
ot = SelfCall(t,75);

% set figure
asd = [135/250 206/250 250/250];
set(clf,'color',asd,'menubar','none', ...
    'numbertitle','off','name','ecgfig', ...
    'ToolBar','none')
axis off;

xlim([0 10]);

drawnow;

% -- set control bar
stop = uicontrol('style','toggle','string','stop', ...
    'background','white');
hold on
comet_me(t,ot);
ot = SelfCall(t,rand*100);
drawnow;
% main loop-by while and stop icon
astar = tic;
% while ~get(stop,'value') && toc(astar) > 10
while ~get(stop,'value') 
    if toc(astar) > 1
        cla;
        astar = tic;
        Comet_figure(t,rand*20 + 10)
        drawnow;
        hold on;
    end
end

fprintf('Finished \n');
end


% Compute Origin Datas
function ot = SelfCall(x,rate)
% parameters
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
ot=pwav+qrswav+twav+swav+qwav+uwav;
end

%% 
function Comet_figure(t,rate)
    ot = SelfCall(t,rate);
    comet_me(t,ot);
%     comet(t,ot);
    drawnow;
end