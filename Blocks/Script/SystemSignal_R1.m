%%
clc;
ScriptPath = 'D:\Codes\MatlabFiles\Blocks\';
if ~isequal(ScriptPath,pwd)
    cd(ScriptPath)
end
fprintf('加载路径:%s\n',pwd);
%%
%{
    1.雷克子波
    x(t) = u(t)*exp(-αt)*sin(βt)
    reference:《信号分析与处理》
%}
clc;
RickerWavelet = @(a,b,t)exp(-a.*t).*sin(b.*t);
t = linspace(0,10,10000);
y = RickerWavelet(5,20,t);

f1 = figure;
figure(f1)
title('ricker wavelet')
plot(t,y)
grid minor


