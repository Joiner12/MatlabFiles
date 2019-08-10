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
filename = datestr(now,'Logyyyymmdd')