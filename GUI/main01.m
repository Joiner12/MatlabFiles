clc
disp('Matlab Gui Block')
PurposePath = 'D:\Coders\MatlabScrips\GUI';
if ~strcmp(PurposePath,pwd)
    cd D:\Coders\MatlabScrips\GUI
end
fprintf('load path\t>>>>\t%s\n',pwd)
clear ans

%% 
clc ;
clear;
close all
x = 0:0.01:pi/2;
plot(x,tan(x),'-ro'); 
axis([0 pi/2 0 50]) 
grid on