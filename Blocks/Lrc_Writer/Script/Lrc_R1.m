%%
Filepath = 'D:\Codes\MatlabFiles\Blocks\Lrc_Writer\Script';
cd(Filepath)
%%
clc;clear;
while true
    pause(1);
    fprintf('%s:',datestr(datetime('now'),'HH:MM:SS'));
    lrc()

end