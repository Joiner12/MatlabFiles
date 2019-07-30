%% filepath
ScirptPath = 'D:\Codes\MatlabFiles\Blocks';
if ~isequal(pwd,ScirptPath)
    cd(ScirptPath);
end
fprintf("load path:%s\n",pwd);

%%
%{
    Design thoughts:

%}
clc;clear;
close all;
disp('Run time table script')
Time_01 = tic;
timetable = 'C:\Users\10520\Desktop\TimeItem.txt';
table_origin = readtable(timetable,'Delimiter','|',...
    'FileEncoding','utf-8','ReadVariableNames',false...
    );

%--------------Get origin table-------------%
valid_table = table_origin(1:end,2:5);
valid_table_size = size(valid_table);
emptyline = 1;

for i = 1:1:valid_table_size(1)
    emptylineflag = true;
    for k = 1:1:valid_table_size(2)
        chartemp = char(valid_table{i,k});
        emptylineflag = emptylineflag & isempty(chartemp);
    end
    if emptylineflag
        emptyline = i-1;
        break;
    end
end
valid_table = valid_table(1:emptyline,1:end);

%-----------------Valid cell----------------%
valid_cell = table2cell(valid_table);
size_temp = size(valid_cell);
for i = 1:1:size_temp(1)
    if i > 1
        for k = 1:1:size_temp(2)
            if isempty(char(valid_cell(i,k)))
                valid_cell{i,k} = valid_cell{i-1,k};
            end
        end
    end
end
% table && cell are same;
valid_cell(2,:) = [];
valid_cell(1,:) = [];

clear chartemp emptyline emptylineflag i k size_temp timetable ...
    table_origin valid_table_size


%--------------------valid struct ----------------%
heading = {'date','time','item','other'};
% todo:@parameter 2 ???? 
valid_struct = cell2struct(valid_cell,heading,2);
structSizeTemp = size(valid_struct);
% clc;
disp('valid datas input')

for i = 1:1:structSizeTemp(1)
    % 
    data_temp = valid_struct(i).date;
    rep = strrep(strrep(strrep(data_temp,'年','/'),'月','/'),'日'," ");
    valid_struct(i).date = rep;
    timetemp = split(valid_struct(i).time,'-');
    startTimeTemp = strcat(rep,timetemp(1));
    finishTimeTemp = strcat(rep,timetemp(2));

    interTemp = etime(datevec(finishTimeTemp,'yyyy/mm/dd HH:MM'),...
                      datevec(startTimeTemp,'yyyy/mm/dd HH:MM'));
    if interTemp < 0
        warning('...');
        % fprintf('rows-> (%d) time calculation may wrong->(%d)\n',i,interTemp);
        interTemp = abs(interTemp);
    end
    valid_struct(i).interval = int32(interTemp/60);  % min

    % Morning Afternoon Night DeepNight
    MAND = ["Morning","Afternoon","Night","DeepNight"];
    mandtemp = datevec(startTimeTemp,'yyyy/mm/dd HH:MM');
    mandtemp = mandtemp(4);

    if mandtemp >= 6 && mandtemp < 12
        mandtemp = MAND(1);
    elseif mandtemp >=12 && mandtemp < 19
        mandtemp = MAND(2);
    elseif mandtemp >= 19 && mandtemp < 21
        mandtemp = MAND(3);
    else
        mandtemp = MAND(4);
    end
    valid_struct(i).mand = mandtemp;
end
disp('Valid Struct Got')
toc(Time_01)
% clear data_temp finishTimeTemp heading MAND len_temp i mandtemp;
% clear rep structSizeTemp startTimeTemp interTemp timetemp

%--------------原始表格获取完成--------------%

%--------------统计分析-------------%
%{
    设计思路：
    1.初步统计事项，时间
%}
disp('统计分析...')
anlysis_1 = true;
if anlysis_1
    periods = zeros(0);
    pie_labels = string(0);
    len_temp = size(valid_struct);

    for i = linspace(1,len_temp(1),len_temp(1))
        periods(i) = valid_struct(i).interval;
        pie_labels(i) = string(valid_struct(i).item);
    end
    explode = logical(periods);
    pie_temp = double(periods);
    if true
        disp('绘制粗略图')
        figure('name','概图')
        subplot(1,2,1)
        suptitle('概图');
        if true
            bar(pie_temp,'FaceColor','c','EdgeColor',[0 .5 .5],...
            'LineWidth',1.5)
        else
            bar(pie_temp,'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],...
            'LineWidth',1.5)
        end
        grid on
        subplot(1,2,2)
        pie(pie_temp,explode,pie_labels);
        grid on
    end
end
toc(Time_01)
%%
%--------------统计分析-------------%
%{
   设计思路：
   1.GUI；
   2.每天有效时间；
   3.大类时间，具体事项时间；
   4.数据存储格式选择cell；
%}
% clc;
board = strings(0);
detail = strings(0);
board_temp = "";
detail_temp = "";
days_temp = "";
daynum = 0;
anlysis_items = true;
% 每天有效时间
% datatimesize_temp = []
% datatime = table();
if anlysis_items
    % 天数统计
    
    for i = linspace(1,len_temp(1),len_temp(1))
        periods_temp = valid_struct(i).interval;
        thing_temp = string(valid_struct(i).item);
        if ~contains(board_temp,thing_temp)
            board_temp = board_temp + " " + thing_temp;
        end
    end
    %云图
    if true
        % 删除空字符
        repCharters_1 = [];
        board = join(board_temp);
        board = split(board," ");

        board(strlength(board) < 1) = [];
        % 云图
        if true
            disp('绘制云图')
            figure('name','云图')
            draw_words = categorical(board);
            wordcloud(draw_words,linspace(1,length(draw_words),length(draw_words)));
        end
    end
end
% clear explode i len_temp periods pie_labels pie_temp anlysis_1
%% 
%---------统计一天有效时间-----------%
%{
    设计思路：
    1.nestedstruct结构存储；
    2.统计一天有效时间；
%}
% clc;
disp('统计一天有效时间')
% hours
days = hours(datetime(valid_struct(end).date) ...
             - datetime(valid_struct(1).date));
days = days/24;
fprintf('All days:%d\n',days);

valid_day_neststruct = struct('date',{},'validPeriod',{},'item',...
                             struct('detail',{},'detailPeriod',{}));

% 日期在struct中的位置
datePosTemp = zeros(0);
nestStructCnt = 1;
dateStrTemp = "";
for i=1:1:length(valid_struct)
    % nestStruct(n).date
    if ~isequal(dateStrTemp, datestr(datetime(valid_struct(i).date),'yyyy-mm-dd'))
        dateStrTemp = datestr(datetime(valid_struct(i).date),'yyyy-mm-dd');
        valid_day_neststruct(nestStructCnt).date = dateStrTemp;
        datePosTemp(nestStructCnt) = i;
        nestStructCnt = nestStructCnt + 1;
    end
    if i == length(valid_struct)
        datePosTemp(nestStructCnt) = length(valid_struct);
    end
end

% 每天有效时间统计 min
nestStructCnt = 1;
for i = 1:1:length(datePosTemp)-1
    valid_day_neststruct(nestStructCnt).validPeriod = 0;
    try
        for k = linspace(datePosTemp(i),datePosTemp(i+1),datePosTemp(i+1) - datePosTemp(i)+1)
            valid_day_neststruct(nestStructCnt).validPeriod =...
             valid_day_neststruct(nestStructCnt).validPeriod...
             + valid_struct(k).interval;
        end
    catch
        fprintf('索引错误%d\n',k);
    end
    nestStructCnt = nestStructCnt + 1;
end
% 绘制柱状图
if true
    datePeriod = zeros(0);
    datePeriodDate = strings(0);
    for i=1:1:length(valid_day_neststruct)
        datePeriod(i) = valid_day_neststruct(i).validPeriod/60;
        datePeriodDate(i) = string(valid_day_neststruct(i).date);
        cg_datePeriodDate = categorical(datePeriodDate);
    end 
    pic_name01 = 'draw day vliad period';
    disp(pic_name01)
    figure('name','有效时间柱状图')
    bar(cg_datePeriodDate,datePeriod,'FaceColor',[0 .5 .5],...
        'EdgeColor',[0 .9 .9],'LineWidth',1.5)
    set(get(gca, 'Title'), 'String', pic_name01);
    set(get(gca, 'XLabel'), 'String', '小时');
    grid on
end
toc(Time_01)
