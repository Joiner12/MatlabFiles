ScriptPath = 'H:\MatlabFiles\Blocks';
if ~isequal(ScriptPath,pwd)
    cd(ScriptPath);
end
fprintf("load script path: \n%s\n",pwd);

%% Anonymous function draw 
%{
    e.g:x.^2 + y.^2 = 0;
%}
clc;
close all;
func_1 = @(x,y) y.*sin(x)+x.*cos(y)-1;
fp = fimplicit(func_1,[-5 5 -5 5]);
fp.Color = [0.50 0.42 0.68];
fp.LineStyle = '--';
fp.LineWidth = 2;
grid minor


%% anonymous draw and magnify
%{
    e.g:f(x,y) = x+y
%}
clc;
try
    close('ip')
catch
    fprintf('aha\n')
end
func_sin = @(x) sin(x) + 0.01*rand;
func_sin_1 = @(x) sin(x + 0.1);


f1 = figure('name','ip');
fp1 = fplot(func_sin,[0 2*pi]);
hold on
fp2 = fplot(func_sin_1,[0 2*pi]);
grid on

magnify()