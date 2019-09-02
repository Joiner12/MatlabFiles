clc;
clear;
close all
figure;
x = 0;
y = 2;
% x = linspace(1,10,10);
% y = linspace(1,1,10);
barh(x,y,1)
ylim([0 0.5])

%%
clc;
clear;
t1 = datetime('now');
pause(5)
t2 = datetime('now');
etime(datevec(t2),datevec(t1))

%% 
logpath = 'D:\Codes\MatlabFiles\Blocks\TickTockFiles';
logname = 'log.txt';
clc;
log = fopen('\log.txt','a+');
if log ~= 0
    
    infowrite = num2str(rand*1000);
    fprintf(log,'%s\n',infowrite);
end
fclose(log);

%% 
clc
StartTick = datestr(datetime('now'),'yy/mm/dd  HH:MM');
etime(datevec(datetime('now')),datevec(StartTick))
filename = datestr(now,'Logyyyymmdd');

%% 
clc;
clear all;
ans_01 = {'sdf','fds'};
anafd = ans_01{1};
fprintf('%s\n',ans_01{1})

%% openfile 
file = 'C:\Users\10520\Desktop\draft.txt';
winopen(file)

%%
prompt_01 = {'ItemName','ItemDetail'};
title_01 = 'KEEP INFO';
dims_01 = [1 40];
answer_01 = inputdlg(prompt_01,title_01,dims_01);

%% 
try 
    cd('F:\')
catch
    disp('f')
end

%% 
clc;close all;
f = figure('name','pic');
p = plot(1,1)
back_tab01 = imread('D:\±ÚÖ½\Wallpaper_2.jpg');
imshow(back_tab01,'Parent',p);

%% 
clc;clear;
fatherfolder = dir('D:\Codes\MatlabFiles\Blocks\TickTockFiles');
childfolders = strings(0);
logpath = 'D:\Codes\MatlabFiles\Blocks\TickTockFiles\Logs';
for i = 3:1:length(fatherfolder)
    childfolders(i-2) = fatherfolder(i).name;
end
strfind(childfolders,"Logs")

%% 
% watingbar
