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
back_tab01 = imread('D:\锟斤拷纸\Wallpaper_2.jpg');
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
% 19/09/16  22:00:04	|
clc;
prompt = {'Start Time','Finish Time','Item','Detail'};
dlgtitle = 'Add a piece of Time log';
dims = [1 60];
dateformat = 'yy/mm/dd HH:MM';
defaultTime = datestr(datetime('now'),dateformat);
definput = {defaultTime,defaultTime,'',''};
answer = inputdlg(prompt,dlgtitle,dims,definput);
startTemp = defaultTime;
finishTemp = defaultTime;
if isempty(answer)
    info_temp = 'cancle';
    return;
end

startTemp = answer{1};
starttemp = datestr(startTemp,'HH:MM');
finishTemp = answer{2};
finishtemp = datestr(finishTemp,'HH:MM');
gaptemp = minutes(duration(finishtemp,'InputFormat','hh:mm')...
    - duration(starttemp,'InputFormat','hh:mm'));
% app.LogPath = ' D:\Codes\MatlabFiles\Blocks\TickTockFiles\Logs';
LogPath = ' D:\Codes\MatlabFiles\Blocks\TickTockFiles\Logs';
filenameTemp = strcat('20', datestr(answer{2},'yy-mm-dd'));
filetxt = fopen(strcat(fullfile(LogPath,filenameTemp),'.txt'),'a+');
if filetxt ~= 0
    % fprintf(filetxt,'%s\t%s\t%s\t%s\t%d\n',)
    fprintf(filetxt,'%s\t|\t%s\t|\t%s\t|\t%s\t|\t%d\n',strcat(answer{1},':00')...
        ,strcat(answer{2},':00'),answer{3},answer{4},gaptemp);
end
fclose(filetxt);
% winopen(filenameTemp)
% txtfile = fopen()

% close()

%%
clc;
newlogfile = false;
for i = linspace(1,length(dirans(1,:)),length(dirans(1,:)))
    temp = dirans{1,i};
    if isequal(temp,answer{1})
        fprintf('equal')
    else
        fprintf('noth')
    end
end

%%
%{
    日志查看，选择日期
%}
uf = uifigure;
d = uidatepicker(uf)
d.InnerPosition = [1 1 150 20];
d.Value
d.DisplayFormat = 'yyyy-M-dd';
%% 
%{
    dir
%}
clc;
a = dir('D:\Codes\MatlabFiles\Blocks\TickTockFiles\Logs');
file_temp = "";
for i = 1:1:length(a)
    file_temp = strcat(a(i).name,'|',file_temp);
end
strfind(file_temp,datestr(datetime('tomorrow'),'yyyy-mm-dd'))

%% 
promt_1 = '不要点了，没想好写啥！！';
h = msgbox(promt_1,'Nan','help');
delete(h)
%% 
clc;
Gen_Ans = questdlg('生成报表?','Report','Yes','No','No');
switch Gen_Ans
    case 'Yes'
        tableTemp = readtable('C:\Users\10520\Desktop\2019-10-02.txt');
%         fileID = fopen('C:\Users\10520\Desktop\2019-10-02.txt','r');
        fprintf('generate report\n');
%         fclose(fileID);
    otherwise
end

%% 
clc;clear;
tableTemp = readtable('C:\Users\10520\Desktop\2019-10-02.txt','Delimiter','|');
detailArrayTemp = strings(0);
detailArrayTimeTemp = zeros(0);
detailTemp = "";
detailCntTemp = 1;
for i = 1:1:length(tableTemp.Var1)
    % 补全表格
    if isempty(tableTemp.Var4(i)) || isempty(tableTemp.Var5(i))&& i > 1
        tableTemp.Var4(i) = tableTemp.Var4(i-1);
        tableTemp.Var5(i) = tableTemp.Var5(i-1);
    end
    % dictionary
    if ~contains(detailTemp,char(tableTemp.Var4(i)))
        detailTemp = strcat(detailTemp,tableTemp.Var4(i));
        detailArrayTemp(detailCntTemp) = tableTemp.Var4(i);
        detailArrayTimeTemp(detailCntTemp) = 0;
        detailCntTemp = detailCntTemp + 1;
    end
end
clearvars i;
%dictionary
for i = 1:1:length(tableTemp.Var1)
    for j = 1:1:length(detailArrayTemp)
        if detailArrayTemp(j) == tableTemp.Var4(i)
            postemp = j;
            break;
        end
    end
    detailArrayTimeTemp(postemp) = detailArrayTimeTemp(postemp) + ...
        tableTemp.Var5(i);
end
%% 
% 生成bar数据
clc;
tempCell = cell(size(detailArrayTemp));
for j = 1:1:length(detailArrayTemp)
    tempStr = strcat(detailArrayTemp(j),'|',num2str(detailArrayTimeTemp(j)));
    tempStr = char(tempStr);
    tempCell{j} = tempStr;
end

if length(detailArrayTemp)==1
    return;
end
f = figure(1);
subplot(211)
pie(detailArrayTimeTemp,detailArrayTemp)
subplot(212)
ar = detailArrayTimeTemp';
b2 = bar(detailArrayTimeTemp);
b1 = bar(categorical(tempCell),detailArrayTimeTemp);
cla(f,'reset')

%% 
%{
    读取歌词文件
%}
clc;
filepath = 'D:\Softwares\foobar2000\lyrics\';
flc = dir(filepath);
lrcfile = strings(0);
cnt = 1;
for i=2:1:length(flc)
   if contains(flc(i).name,'.lrc')
       lrcfile(cnt) = flc(i).name;
       fprintf('%s\n',lrcfile(cnt));
       cnt = cnt + 1;
   end
end

%% 
clc;
options = weboptions('RequestMethod','get','CharacterEncoding','UTF-8');
url = 'http://news.iciba.com/views/dailysentence/daily.html#!/detail/title/2019-10-03';
strf = webread(url,options);
tarFile = 'C:\Users\10520\Desktop\daily.txt';
websave(tarFile,url)

%%
4a572ea 4c4dd33