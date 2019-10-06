clc;
clear;
if ~isequal('D:\Codes\MatlabFiles\Blocks',pwd)
    cd('D:\Codes\MatlabFiles\Blocks')
end
fprintf('Reload path: \t%s\n',pwd);
%%
%{
    网页爬虫，正则表达式
%}
clc;clear;
url_daily = 'http://www.dailyenglishquote.com/';
options = weboptions('RequestMethod','get','CharacterEncoding','UTF-8');
url = '';
strf = webread(url_daily,options);
tarFile = 'C:\Users\10520\Desktop\daily.txt';
websave(tarFile,url_daily);
%%
tic
try
    
catch EM
    fprintf('%s\n',EM.identifier);
end

%%
% 使用标文匹配提取<p>
clc;
% expression_3 = '<(\w+).*?>.*?</\1>';
expression_3 = '<(p).*?>.*?</\1>';
strf_3 = regexp(strf,expression_3,'match');
for i=1:1:length(strf_3)
    strf_3(i)
end
%%
clc;
strf_4 = strf_3(1:2)

%%
exps = ['(?<=&#\d{4};).*?(?=&#)','(?<=;">).*?(?=</)']
en_str = regexp(strf_4{1},expression_4,'match');
for i=1:1:length(en_str)
    en_str(i)
end
expression_5 = '(?<=「).*?(?=」)';
cz_str = regexp(strf_4{2},expression_5,'match')
expression_6 = '(?<=\d{4};).*?(?=</p>)';
author = regexp(strf_4{2},expression_6,'match')

