%%  
clc;clear;
Path = 'D:\Codes\MatlabFiles\KalmanFilter';
if ~strcmp(pwd,Path)
    cd D:\Codes\MatlabFiles\KalmanFilter
end
fprintf('Load Path\t%s\n',Path);
clear Path

%% 
clear 
NetMusicUrl = 'https://music.163.com/?from=infinity';
shangHai = 'http://quote.eastmoney.com/zs000001.html';
SpecUrl = shangHai;
[SourceCode,Status] = urlread(SpecUrl);
if ~Status
    error('....')
    why
    return ;
else
    fprintf('Get url succeed...\n');
end

% <a href="http://quote.eastmoney.com/center/list.html#mk0146_12" target="_blank" class="sg">港股通(深)</a>
expr01 = '<a href=".*?</a>';
% expr01 = '(?<=<a href=").*?(?=</a>)';

datafile = {};
TryMore = 0; % Try more times to ensure got origin code from the page
[datafile] = regexp(SourceCode,expr01,'match');
while  ~isempty(datafile)&&(TryMore < 10)
     TryMore = TryMore + 1;     
     [datafile] = regexp(SourceCode,expr01,'match');
end

if  ~isempty(datafile)
    fprintf('Info got from the page:\t%s\n',SpecUrl);
else
    warning('Check expression,Nothing got')
end

for i=1:1:length(datafile)
    fprintf('%s\n',datafile{1,i})
end


%%
% search out users info
clc
userslink = {};
% <img data-value="http://avator.eastmoney.com/qface
% /4470094325239696/50" src="" border="0">
% expr01 = '(?<=<a href=").*?(?=</a>)';
expr03 = '(<img data-value=").*?(" src="" border="0">)';
% expr03 = '(?<=<img data-value=").*?(?=" src="" border="0">)';
[userslink] = regexp(datafile,expr03,'match');