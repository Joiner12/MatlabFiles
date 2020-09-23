%% Search all *.txt
clc;clear;
TargetPath = 'H:\MatlabFiles\ChildBlocks';
CurPath = pwd;
% if CurPath == TargetPath
if strcmp(CurPath,TargetPath)
    fprintf('Road...%s\t\n%s\n',pwd,'ChildBlocks');
else
    cd(TargetPath)
end
clear ans CurPath TargetPath

%% 
clc
path = 'H:\MatlabFiles\FrequencyObserver\Datas\2019-4-28-V1';
file = dir(path);
global counter;
counter = 0;
detailname = string(size(file));
detailname = detailname';
for i = 1:1:(size(file))
    detail = file(i,1);
    if strfind(detail.name,'.txt')
        counter = counter+1;
%         disp(detail.name);
        detailname(counter) = detail.name; 
%         detailname(counter)= counter;
    end
end 

detailname