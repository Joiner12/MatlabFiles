%% path
TargetPath = 'H:\MatlabFiles\ChildBlocks';
CurPath = pwd;
% if CurPath == TargetPath
if strcmp(CurPath,TargetPath)
    pwd
else
    cd H:\MatlabFiles\ChildBlocks
end
clear ans CurPath TatgetPath
%% 
x1 = 0.0001:1:1000;
y1 = -20*log10(x1);
figure
plot(x1,y1)
grid on 


%% 
clc;clear ;
[filename,pathname] = uigetfile({'*.txt'},'File Selector','C:\Users\Whtest\Desktop');
if isequal(filename,0)
    disp('User cancle')
else
    disp(['User Select-->',fullfile(pathname,filename)])
end
