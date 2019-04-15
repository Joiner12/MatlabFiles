%% 
clc;
disp('ADRC Block')
PurposePath = 'D:\Coders\MatlabScrips\ADRC';
if ~strcmp(PurposePath,pwd)
    cd D:\Coders\MatlabScrips\ADRC
end
fprintf('load path\t>>>>\t%s\n',pwd)
clear ans
%% test for transition process arranging 
trans(10,1,2)