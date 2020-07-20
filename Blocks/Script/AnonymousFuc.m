% filepath
clc;
targetPath = 'H:\MatlabFiles\Blocks';
if ~isequal(targetPath,pwd)
    cd(targetPath);
end
fprintf('load path....\n%s\n',pwd);

%% 
clc;
% clear;
% ÄäÃûº¯Êý
h = @(x) sin(x);
h1 = @(x,y) cos(x)+sin(y);
h2 = @(t1,t) 2*exp(t1*t);
% h1(linspace(1,10,10),linspace(1,10,10))

t = linspace(0,10,1000);
y_delay = h2(1,t);
figure
plot(t,y_delay)
grid minor

