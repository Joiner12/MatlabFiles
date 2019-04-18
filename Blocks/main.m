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
SinSingnal(128,100,5,1);


