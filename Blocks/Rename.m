%% 脚本路径 
Filepath = 'D:\Codes\MatlabFiles\Blocks';
cd(Filepath)

%%
clc;
clear;
disp('重命名......')
des = 'D:\壁纸';
detail = dir(des);
start = 'Wallpaper_';
cnt = 000;
for i=3:1:length(detail)
    filename = detail(i).name;
    oldname = fullfile(detail(i).folder,detail(i).name);
    % bmp
    if contains(filename,'bmp') 
        cnt = cnt + 1;
        newname = strcat(start,num2str(cnt),'.bmp');
        command = ['rename' 32 oldname 32 newname];
        status = dos(command)
    end
    % jpg
    if contains(filename,'jpg')
        cnt = cnt + 1;
        newname = strcat(start,num2str(cnt),'.jpg');
        command = ['rename ' 32 oldname 32 newname];
        status = dos(command)
    end
    % png
    if contains(filename,'png')
        cnt = cnt + 1;
        newname = strcat(start,num2str(cnt),'.png');
        command = ['rename ' 32 oldname 32 newname];
        status = dos(command)
    end
end