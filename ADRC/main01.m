%% 
clc;
disp('ADRC Block')
PurposePath = 'D:\Codes\MatlabFiles\ADRC';
if ~strcmp(PurposePath,pwd)
    cd D:\Codes\MatlabFiles\ADRC
end
fprintf('load path\t>>>>\t%s\n',pwd)
clear ans
%% test for transition process arranging 
trans(10,1,2)

%%  compass 
rng(0,'twister');
M = randn(20,2);
if 0
    M1 = sind(M(:,1));
    M2 = cosd(M(:,2));
    figure
    compass(M1,M2)
else
    close all
    figure
    compass(M(:,1),M(:,2))
    figure 
    scatter(M(:,1),M(:,2))
    grid on
end
    
