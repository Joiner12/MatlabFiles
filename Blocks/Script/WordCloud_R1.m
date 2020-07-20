% sript path
clc;
Scriptpath = 'H:\MatlabFiles\Blocks';
if ~isequal(Scriptpath,pwd)
    cd(Scriptpath)
end
 fprintf('script path : %s\n',pwd);
%% WORD CLOUD
%{
    设计思路：
    1.*.txt提供词源；
    2.使用 
%}
clc;clear;
punccharacters_1 = ["{","}","//","/","*","|","(",")","."];
punccharacters_2 = [">","&",";","-","+","%","=",",",":","#"];
% fileread():将数据以string形式读入
filename = "C:\Users\Whtest\Desktop\kalman.txt";
% filename = "C:\Users\Whtest\Desktop\devilorangel.txt";
contens_str = string(fileread(filename));
content_1 = replace(contens_str,[punccharacters_1,punccharacters_2]," ");
% 多维字符串连接，将字符串按照空格拆分为一维字符串数组
content_2 = split(join(content_1));
% 删除短字符串
content_2(strlength(content_2) < 5) = [];
% 分类数组，删除重复字符串的功能
text_final = categorical(content_2);

figure(1)
wordcloud(text_final)
