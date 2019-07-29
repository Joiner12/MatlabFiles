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
disp('Run time table script')
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


%--------------------nothing ----------------%
heading = {'date','time','item','other'};
% todo:@parameter 2 ???? 
valid_struct = cell2struct(valid_cell,heading,2);
structSizeTemp = size(valid_struct);
clc;
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
        fprintf('rows-> (%d) time calculation may wrong->(%d)\n',i,interTemp);
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

% clear data_temp finishTimeTemp heading MAND len_temp i mandtemp;
% clear rep structSizeTemp startTimeTemp interTemp timetemp

%--------------原始表格获取完成--------------%

%--------------统计分析-------------%
%{
    设计思路：
    1.初步统计事项，时间
%}
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
    if false
        figure(1)
        subplot(1,2,1)
        suptitle("???????");
        % plot(pie_temp)
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

%% 
%--------------统计分析-------------%
%{
   设计思路：
   1.GUI；
   2.每天有效时间；
   3.大类时间，具体事项时间；
   4.数据存储格式选择cell；
%}
clc;
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
        % 天数统计
        % if ~contains(days_temp,valid_struct(i).date)
        %     days_temp = days_temp + " " + valid_struct(i).date;
        %     daynum = daynum + 1 ;
        % end

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
            draw_words = categorical(board);
            wordcloud(draw_words,linspace(1,length(draw_words),length(draw_words)));
        end
    end
end

%
% clear explode i len_temp periods pie_labels pie_temp anlysis_1
%% 
% day_1 = valid_struct(end).date - valid_struct(1).date;
