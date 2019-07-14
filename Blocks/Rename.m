%% 重命名
Filepath = 'D:\Codes\MatlabFiles\Blocks';
cd(Filepath)

%%
%
clc;
clear;
des = 'D:\壁纸';
fprintf('%s,重命名启动\n', des);
detail = dir(des);
start = 'Wallpaper_';

VerSwitch = 2;

switch VerSwitch
        %------------Version 1.0--------------%
    case 1
        cnt = 0;

        for i = 3:1:length(detail)
            filename = detail(i).name;
            oldname = fullfile(detail(i).folder, detail(i).name);
            % bmp
            if contains(filename, 'bmp')
                % cnt = cnt + 1;
                newname = strcat(start, num2str(cnt + 1), '.bmp');
                command = ['rename' 32 oldname 32 newname];
                status = dos(command);
                %
                if status == 0
                    cnt = cnt + 1;
                    % fprintf('%s???????%s\n', oldname, newname);
                end

            end

            % jpg
            if contains(filename, 'jpg')
                newname = strcat(start, num2str(cnt + 1), '.jpg');
                command = ['rename ' 32 oldname 32 newname];
                status = dos(command);

                if status == 0
                    cnt = cnt + 1;
                    % fprintf('%s???????%s\n', oldname, newname);
                end

            end

            % png
            if contains(filename, 'png')
                newname = strcat(start, num2str(cnt), '.png');
                command = ['rename ' 32 oldname 32 newname];
                status = dos(command);

                if status == 0
                    cnt = cnt + 1;
                    % fprintf('%s???????%s\n', oldname, newname);
                end

            end

        end

        %------------Version 2.0--------------%
        %{
            1.解决重命名，只对不符合规范文件进行命名问题；
            设计思路：
            1.初始化重命名；
            2.再按照标准进行重命名；
        %}
    case 2
        standerd = start;
        effectFileCnt = 0;
        unnamedCnt = 0;
        filePos = zeros(0);
        file_size = length(detail);
        
        %--------------- 空文件夹操作---------------%
        if isequal(file_size,2)
            disp('文件夹为空');
            return;
        else
            fprintf('文件总数：%d\n',file_size);
        end

        %------------重命名操作--------------%
        file_types = [".bmp",".jpg",".png"];
        init_renameflag = false;
        for i = 1:1:length(detail)
            if isempty(strfind(detail(i).name, standerd)) && contains(detail(i).name,file_types)
                unnamedCnt = unnamedCnt + 1;
                filePos(unnamedCnt) = i;
                init_renameflag = true;
                fprintf("%s \t %d\n",detail(i).name,unnamedCnt);
            end
        end
        %@ parameter: 初始化标志
        %@ parameter: 文件结构体
        if init_renameflag
            InitRename(init_renameflag,detail);
            detail = dir(des);
            RenameMain(detail,start);
        else
            disp("无需重命名，按任意键退出")
            pause
        end
end
%% 测试初始化函数
if false
    clc;clear;
    des = 'D:\壁纸';
    file_in = dir(des);
    InitRename(true,file_in)
end
%%
%--------------初始化重命名--------------%
function InitRename(init_flag,file)
    if init_flag
        cnt_2 = 0;
        rename_cnt_0 = 100*int32(rand*100);
        suffix =  ["bmp","jpg","png"];
        for i = 1:1:length(file)
            file_name_i = file(i).name;
            if contains(file_name_i,suffix)
                oldname_1 = strcat(file(i).folder,'\',file(i).name);
                suffix_detail = file(i).name(strfind(file(i).name,'.'):end);
                cnt_2 = cnt_2 + 1;
                newname_1 = strcat(num2str(cnt_2 + rename_cnt_0),suffix_detail);
                command = ['rename ' 32 oldname_1 32 newname_1];
                status_1 = dos(command);
                if status_1 == 0
                    fprintf("%s rename %s\n",oldname_1,newname_1);
                else
                    status_1
                end
            end
        end 
    else
        disp('There is no need for init name');
        return;
    end
end

%--------------重命名函数----------------------%
function RenameMain(file,start)
    cnt_2 = 0;
    suffix =  ["bmp","jpg","png"];
    for i = 1:1:length(file)
        file_name_i = file(i).name;
        if contains(file_name_i,suffix)
            oldname_1 = strcat(file(i).folder,'\',file(i).name);
            suffix_detail = file(i).name(strfind(file(i).name,'.'):end);
            cnt_2 = cnt_2 + 1;
            newname_1 = strcat(start,num2str(cnt_2),suffix_detail);
            command = ['rename ' 32 oldname_1 32 newname_1];
            status_1 = dos(command);
            if status_1 == 0
                fprintf("%s rename %s\n",oldname_1,newname_1);
            else
                status_1
            end
        end
    end 
   fprintf('%s重命名结束\n',file(1).folder)
end

%% 编译生成exe文件
% mcc -m Rename