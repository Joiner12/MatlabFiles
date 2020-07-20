%%
clc;
ScriptPath = 'D:\Codes\MatlabFiles\Blocks\';
if ~isequal(ScriptPath,pwd)
    cd(ScriptPath)
end
fprintf('����·��:%s\n',pwd);
%%
%{
    1.�׿��Ӳ�
    x(t) = u(t)*exp(-��t)*sin(��t)
    reference:���źŷ����봦��
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


