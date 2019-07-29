%% 
clc;
ScriptPath = 'D:\Codes\MatlabFiles\Blocks\';
if ~isequal(ScriptPath,pwd)
    cd(ScriptPath)
end
fprintf('加载路径:%s\n',pwd);

%%
%{
    设计思路：
    1.语义分割；
    2.词云；
%}
clc;
file ='C:\Users\10520\Desktop\word.txt';
DrawWordsCloud(file)


%% 
%{
    @parameters:word :字符串数组 
    @fullfile:数据.txt
%}
function DrawWordsCloud(fullfile)
    fprintf('绘图程序调用\n');
    tic
    repCharters_1 = ["." "?" "!" "," ";" ":" "、" "(" "}" ")" "{"];
    repCharters_2 = ["回复" "分享" "|"];
    gbkCharters_1 = ["，" "。" "/" "：" "‘" "”" "“" "！" "？"];
    if 0
        %多次一举的try catch操作
        try
            content = fileread(fullfile);
        catch
            disp('原始数据错误')
        end
    else
        content = fileread(fullfile);
        content_str = string(content);
        content_str = replace(content_str,[repCharters_1 repCharters_2 gbkCharters_1]," ");
        % 将字符串分解成字符串数组
        words = split(join(content_str));
        words(strlength(words) < 1) = [];
        draw_words = categorical(words);
        figure
        wordcloud(draw_words);
    end
    toc
end