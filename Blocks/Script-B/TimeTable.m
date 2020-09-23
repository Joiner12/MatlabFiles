%%
clc;
ScriptPath = 'H:\MatlabFiles\Blocks';
if ~isequal(ScriptPath,pwd)
    cd(ScriptPath);
end
fprintf("load script path: \t%s\n",pwd);
%% timetable
%{
    设计思路: 
    1.读取时间表，标准化;
    2.进行时间统计;
%}
clc;clear;
disp("run time table script")
file = 'C:\\Users\\Whtest\\Desktop\\timetable.txt';
opts = detectImportOptions(file);
opts.VariableNames = {'starttime','endtime','detail','item'};
origin_table = readtable(file,opts);
table_size = size(origin_table);
full_struct = table2struct(origin_table);

cut_position = 1;
for i = 2:1:table_size(1)
    if isempty(origin_table.detail{i}) || isempty(origin_table.item{i})
        full_struct(i).detail = origin_table.detail{cut_position};
        full_struct(i).item = origin_table.item{cut_position};
    else
        cut_position = i;
    end
end


%%
origin_table = readtable(file,'Delimiter','|','ReadVariableNames',false,...
                'Encoding','utf-8');
%---------------提取有效Table-------------------%
valid_table = origin_table(1:end,2:5);
size_table_valid = size(valid_table);
emptyline = 1;
for i = 1:1:size_table_valid(1)
    emptylineflag = true;
    for k=1:1:size_table_valid(2)
        chartemp = char(valid_table{i,k});
        emptylineflag = emptylineflag & isempty(chartemp);
    end
    if emptylineflag
        emptyline = i - 1;
        break;
    end
end
valid_table = valid_table(1:emptyline,1:end);

%-------------补全-------------%
valid_cell = table2cell(valid_table);
size_temp = size(valid_cell);
for i=1:1:size_temp(1)
    if i > 1
        for k=1:1:size_temp(2)
            if isempty(char(valid_cell{i,k}))
                valid_cell{i,k} = valid_cell{i-1,k};
            end
        end
    end
end
% table && cell 类似二维数组
% cell数据删除
valid_cell(2,:) = [];
valid_cell(1,:) = [];

clear i k chartemp emptylineflag size_table_origin size_table_valid ...
    emptyline  origin_table 

%--------------信息提取--------------%
%{
    信息绑定
%}

heading = ["date","time","item","other"];
valid_struct = cell2struct(valid_cell,heading,2);
StructSizeTemp = size(valid_struct);
clc;
disp('valid datas input')
for i = 1:1:StructSizeTemp(1)
    % 格式化时间
    data_temp = valid_struct(i).date;
    rep = strrep(strrep(strrep(data_temp,"年",'/'),'月','/'),'日','');
    valid_struct(i).date = rep;
    timetemp = split(valid_struct(i).time,'-');
    startTimeTemp = strcat(rep,timetemp(1));
    finishTimeTemp = strcat(rep,timetemp(2));
    % 时间统计(s)
    interTemp = etime(datevec(finishTimeTemp,'yyyy/mm/dd HH:MM'),...
    datevec(startTimeTemp,'yyyy/mm/dd HH:MM'));
    if interTemp < 0
        warning('...');
        fprintf('rows->(%d) time calculation may wrong->(%d)\n',i,interTemp);
        interTemp = abs(interTemp);
    end
    valid_struct(i).interval = int32(interTemp/60);  % min

    % Morning afternoon night midnight
    MAND = ["Morning","Afternoon","Night","DeepNight"];
    mandtemp = datevec(startTimeTemp,"yyyy/mm/dd HH:MM");
    mandtemp = mandtemp(4);
    if mandtemp >= 6 && mandtemp < 12
        mandtmemp = MAND(1);
        % fprintf('%d is %s\n',mandtemp,MAND(1));
    elseif mandtemp >= 12 && mandtemp < 19
        mandtmemp = MAND(2);
        % fprintf('%d is %s\n',mandtemp,MAND(2));
    elseif mandtemp >= 19 && mandtemp < 21
        mandtmemp = MAND(3);
        % fprintf('%d is %s\n',mandtemp,MAND(3));
    else
        mandtmemp = MAND(4);
        % fprintf('%d is %s\n',mandtemp,MAND(4));        
    end
    valid_struct(i).mand = mandtmemp;
    % 事件信息构造完成
end
% clear timetemp rep interTemp finishTimeTemp data_temp size_temp...
%     startTimeTemp StructSizeTemp i valid_table

%--------------统计分析--------------%
%--------------统计总时间-------------%
%{
    1.事项 -> 事项详情
    2.数据存储类型
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
    
    % ------绘图------ %
    if false
        figure(1)
        subplot(1,2,1)
        suptitle("统计信息一");
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
%--------------事项统计-------------%
%{
    1.设计思路：
    1.1 具体事情的时间总和;
    1.2 有效时间(不同时间段);
    1.3 GUI;
    1.4 单日有效时间
%}
things = strings(0);
anlysis_items = true;
if anlysis_items
    for i = linspace(1,len_temp(1),len_temp(1))
        periods_temp = valid_struct(i).interval;
        thing_temp = string(valid_struct(i).item);
        % contains()
        things(i) = "";
    end
end

% 删除局部变量
if false
    clear explode i len_temp periods pie_labels pie_temp anlysis_1
    clear things mandtmemp mandtemp heading file anlysis_items MAND
end

%% 
%{
    datestr,datetime,datenum,datevec
%}
clc;
%----------统计一天的有效时间---------%
% nested struct
tic;
%{
    %使用duration算时间
temp_1 = datevec(valid_struct(end).date);
temp_2 = datevec(valid_struct(1).date);
days_lentemp = duartion({char(valid_struct(end).date);char(valid_struct(1).date)})
%}
days_len = etime(datevec(valid_struct(end).date),...
                datevec(valid_struct(1).date)); % s
days_len = days_len/(60*60*24) + 1; % day
fprintf('days = %d\n',days_len);

%% 
valid_day_nestedstruct = struct('date',{},'validDuration',{},'item',...
                                struct('detail',{},'duartion',{}));
while_cnt =  0;
preWhileCnt = 0;
for i = 1:1:days_len
    days_str_temp = datestr(datetime(valid_struct(1).date)...
                    + i - 1,'yyyy-mm-dd');
    valid_day_nestedstruct(i).date = days_str_temp;
    day_duartion_temp = 0;
   
    % while循环数组下标问题
    while true
        valid_struct_date_temp = datetime(valid_struct(while_cnt).date);
        valid_struct_date_temp = datestr(valid_struct_date_temp,'yyyy-mm-dd');
        day_duartion_temp = day_duartion_temp + valid_struct(while_cnt).interval;
        % valid_day_netstruct(i).item.detail(k) = days_str_temp;
        if while_cnt >= length(valid_struct) || ~isequal(days_str_temp,valid_struct_date_temp)
            fprintf('break occured:%d\n',while_cnt - preWhileCnt);
            preWhileCnt = while_cnt;
            break;
        end
        while_cnt = while_cnt + 1;
    end
    valid_day_nestedstruct(i).validDuration = day_duartion_temp;
    
    valid_day_nestedstruct(i).item.duartion(i) = 1;
end
toc;
