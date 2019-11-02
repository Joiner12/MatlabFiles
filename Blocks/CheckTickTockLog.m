clc;
clear;
if ~isequal('D:\Codes\MatlabFiles\Blocks',pwd)
    cd('D:\Codes\MatlabFiles\Blocks')
    fprintf('Reload path: %s\n',pwd);
end
%%
%{


    通过文档导入日志之前，使用此脚本对日志文件进行检查
%}
clc;clear;

% 导入文件
fileopenFlag = true;
[file,path] = uigetfile('C:\Users\10520\Desktop\*.txt');
try
    opt = detectImportOptions(fullfile(path,file));
    opt.Delimiter = ',';
    opt.VariableNames = {'starttime','endtime','item','detail'};
    fileIn = readtable(fullfile(path,file),opt);
catch EM
    % 错误处理
    results = strcat('文件打开失败:',EM.identifier);
    fileopenFlag = false;
end

if fileopenFlag
    NullIndex = 1;
    for i = 1:1:length(fileIn.starttime)
        % 区分大小写
        LogPathus = 'C:\Users\10520\Desktop';
        filetxt = strcat(LogPathus,'\',datestr(fileIn.starttime(i),'yyyy-mm-dd'),'.txt');
        fileId = fopen(filetxt,'a+');
        startTemp = datestr(fileIn.starttime(i),'yy/mm/dd HH:MM:SS');
        finishTemp = datestr(fileIn.endtime(i),'yy/mm/dd HH:MM:SS');
        startDay =  datestr(fileIn.starttime(i),'yy/mm/dd');
        endDay = datestr(fileIn.endtime(i),'yy/mm/dd');
        
        gapTemp = 0;
        formatTemp = 'hh:mm';
        if isequal(startDay,endDay)
            gapTemp = minutes( duration(datestr(fileIn.endtime(i),'HH:MM'),'InputFormat',formatTemp)...
                - duration(datestr(fileIn.starttime(i),'HH:MM'),'InputFormat',formatTemp));
        else
            gapTemp1 = minutes( duration('23:59','InputFormat',formatTemp)...
                - duration(datestr(fileIn.starttime(1),'HH:MM'),'InputFormat',formatTemp));
            gapTemp2 = minutes( duration(datestr(fileIn.endtime(1),'HH:MM'),'InputFormat',formatTemp)...
                - duration('00:01','InputFormat',formatTemp));
            gapTemp = gapTemp1 + gapTemp2;
        end
        itemtemp = fileIn.item{i};
        detailtemp = fileIn.detail{i};
        % item缺失则表示同上条
        if isempty(itemtemp)
            itemtemp = fileIn.item{NullIndex};
            detailtemp = fileIn.detail{NullIndex};
        else
            NullIndex = i;
        end
        % detail缺失则将item复制
        if isempty(detailtemp)
            detailtemp = itemtemp;
        end
        strrep(itemtemp,' ','');
        strrep(detailtemp,' ','');
        fprintf(fileId,'%s\t|\t%s\t|\t%s\t|\t%s\t|\t%d\n',startTemp,finishTemp,itemtemp,detailtemp,gapTemp);
        %         fprintf('%s\t|\t%s\t|\t%s\t|\t%s\t|\t%d\n',startTemp,finishTemp,itemtemp,detailtemp,gapTemp);
        fclose(fileId);
        writeInfo = 'Failure';
    end
end

%% 检查datepicker
DatePicker = uidatepicker();
datetime('now')
