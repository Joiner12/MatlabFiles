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
[file,path] = uigetfile('C:\Users\10520\Desktop\*.txt');
fileIn = readtable(fullfile(path,file),'Delimiter',',');
if isequal(file,0)
    results = 'No File Selcet';
else
    results = 'Log Add by File Succeed';
end
%%
clc;
LogPath = 'D:\Codes\MatlabFiles\Blocks\TickTockFiles\Logs';
LogPathus = LogPath;
writeInfo = 'Succeed';
for i = 1:1:length(fileIn.Var1)
    % 区分大小写
    filetxt = strcat(LogPathus,'\',datestr(fileIn.Var2(i),'yyyy-mm-dd'),'.txt');
    
    fileId = fopen(filetxt,'a+');
    startTemp = datestr(fileIn.Var1(i),'yy/mm/dd HH:MM:SS');
    finishTemp = datestr(fileIn.Var2(i),'yy/mm/dd HH:MM:SS');

    formatTemp = 'hh:mm';
    gapTemp = 0;
    gapTemp = minutes( duration(datestr(fileIn.Var2(i),'HH:MM'),'InputFormat',formatTemp)...
        - duration(datestr(fileIn.Var1(i),'HH:MM'),'InputFormat',formatTemp));
%     fprintf('%s|%s|%d\n',fileIn.Var1(i),fileIn.Var2(i),gapTemp);
    itemtemp = '';
    detailtemp = '';
    if isempty(fileIn.Var3{i}) || isempty(fileIn.Var4{i}) && i > 1
        itemtemp = fileIn.Var3{i-1};
      
        detailtemp = fileIn.Var4{i-1};
      
    else
        itemtemp = fileIn.Var3{i};
        detailtemp = fileIn.Var4{i};
    end
    strrep(itemtemp,' ','');
    strrep(detailtemp,' ','');
%     fprintf(fileId,'%s\t|\t%s\t|\t%s\t|\t%s\t|\t%d\n',startTemp,finishTemp,itemtemp,detailtemp,gapTemp);
    fprintf('%s\t|\t%s\t|\t%s\t|\t%s\t|\t%d\n',startTemp,finishTemp,itemtemp,detailtemp,gapTemp);
    fclose(fileId);
    
    writeInfo = 'Failure';
    
end
