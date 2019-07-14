%% ������
Filepath = 'D:\Codes\MatlabFiles\Blocks';
cd(Filepath)

%%
%
clc;
clear;
des = 'D:\��ֽ';
fprintf('%s,����������\n', des);
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
            1.�����������ֻ�Բ����Ϲ淶�ļ������������⣻
            ���˼·��
            1.��ʼ����������
            2.�ٰ��ձ�׼������������
        %}
    case 2
        standerd = start;
        effectFileCnt = 0;
        unnamedCnt = 0;
        filePos = zeros(0);
        file_size = length(detail);
        
        %--------------- ���ļ��в���---------------%
        if isequal(file_size,2)
            disp('�ļ���Ϊ��');
            return;
        else
            fprintf('�ļ�������%d\n',file_size);
        end

        %------------����������--------------%
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
        %@ parameter: ��ʼ����־
        %@ parameter: �ļ��ṹ��
        if init_renameflag
            InitRename(init_renameflag,detail);
            detail = dir(des);
            RenameMain(detail,start);
        else
            disp("��������������������˳�")
            pause
        end
end
%% ���Գ�ʼ������
if false
    clc;clear;
    des = 'D:\��ֽ';
    file_in = dir(des);
    InitRename(true,file_in)
end
%%
%--------------��ʼ��������--------------%
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

%--------------����������----------------------%
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
   fprintf('%s����������\n',file(1).folder)
end

%% ��������exe�ļ�
% mcc -m Rename