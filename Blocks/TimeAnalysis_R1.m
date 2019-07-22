%% 时间分析
ScirptPath = 'D:\Codes\MatlabFiles\Blocks';
if ~isequal(pwd,ScirptPath)
    cd(ScirptPath);
end
fprintf("load path:%s\n",pwd);

%%
%{
    设计思路:
    1.导入时间分析表，并对时间做统计；
    2.时间统计属性包括：上、下午，事项对应时间长短，具体事项时间花费，
    事项类型统计；
    3.生成统计图表
%}
clc;clear;
disp('run time table script')
timetable = 'C:\Users\10520\Desktop\TimeItem.txt';
table_origin = readtable(timetable,'Delimiter','|',...
    'FileEncoding','utf-8','ReadVariableNames',false...
    );

%--------------提取有效table-------------%
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

%-----------------补全----------------%
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
% table && cell 类似于二维数组
% cell 数据删除
valid_cell(2,:) = [];
valid_cell(1,:) = [];

clear chartemp emptyline emptylineflag i k size_temp timetable ...
    table_origin valid_table_size


%-----------------信息提取----------------%
heading = {'date','time','item','other'};
% todo:@parameter 2 作用 
valid_struct = cell2struct(valid_cell,heading,2);
structSizeTemp = size(valid_struct);
clc;
disp('valid datas input')

for i = 1:1:structSizeTemp(1)
    % 格式化时间
    data_temp = valid_struct(i).date;
    rep = strrep(strrep(strrep(data_temp,'年','/'),'月','/'),'日'," ");
    valid_struct(i).date = rep;
    timetemp = split(valid_struct(i).time,'-');
    startTimeTemp = strcat(rep,timetemp(1));
    finishTimeTemp = strcat(rep,timetemp(2));

    % 统计时间(s)
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

clear data_temp finishTimeTemp heading MAND len_temp i mandtemp;
clear rep structSizeTemp startTimeTemp interTemp timetemp
% ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ 
% 事件信息构造完成

%--------------统计分析--------------%
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
    
    clear explode i len_temp periods pie_labels pie_temp anlysis_1

end
