%% test block
clc;
disp('Test Block')
PurposePath = 'D:\Codes\MatlabFiles\Blocks';
if ~strcmp(PurposePath,pwd)
    cd D:\Codes\MatlabFiles\Blocks
end
fprintf('load path\t>>>>\t%s\n',pwd)
clear ans

%%
clc
wallPaperPath = 'D:\±ÚÖ½';
path = wallPaperPath;
cd(path)
file = dir(wallPaperPath);
picname = file(3:end,1);
for i=1:1:length(picname)
    oldname = picname(i).name
    newname = strcat('1000_',num2str(100+i-1),'.jpg')
%     eval(['!rename' 32 oldname 32 newname])
end

