% filepath
clc;
targetPath = 'H:\MatlabFiles\Blocks';
if ~isequal(targetPath,pwd)
    cd(targetPath);
end
fprintf('load path....\n%s\n',pwd);
%% Nicotine in your body during smoking
%{
    P(t) = k*P0*exp(r*t)/(k + P0*(exp(r*t-1)))
    Nicotine Deisity function: Scale(t) = logsim(t1,0.2,5,1);


    reference:¡¶increse curve of huaman¡·
%}
clc;
fprintf('simulator nicotine scale in blood\n');
logsim = @(t,r,k,p_0) (k + p_0.*(exp(r.*t - 1)))./((k*p_0).*exp(r.*t));
t1 = 60:-0.1:1;

try
    close nicotine
catch
    fprintf('nicotine not opened\n');
end

figure('name','nicotine')
if true
    for i = 0.1:-.01:0.01
        Scale = logsim(t1,0.2,5,i);
        plot(t1,Scale)
        drawnow
        hold on
        pause(1);
    end
else
    Scale = logsim(t1,0.08,5,0.1);
    plot(t1,Scale)
    hold on 
    plot([0 60] ,[1 1],'LineWidth',0.8,'LineStyle','--') 
end
%% 
try
    close('Log Checker')
catch
    fprintf('Log Checker Unopened\n');
end
fig = figure('name','nicotine','units','normalized','position',[.2 .2 .6 .6],...
    'name','Log Checker','numbertitle','off','color','w');
axes('units','normalized','position',[.05 .07 .9 .7]);
grid on;
logsim = @(t,r,k,p_0)((k*p_0).*exp(r.*t)) ./(k + p_0.*(exp(r.*t - 1)));
t1 = 0:0.1:120;
Scale = logsim((60 - t1),0.05,10,0.1);
plot(t1,Scale,'LineWidth',2.5)
grid minor
xlabel('time (min)')