%%
clc;clear;
TargetPath = 'H:\MatlabFiles\ADRC\Scripts';
CurPath = pwd;
% if CurPath == TargetPath
if strcmp(CurPath,TargetPath)
    fprintf('Road...%s\t\n%s\n',pwd,'ADRC');
else
    cd H:\MatlabFiles\ADRC\Scripts
end
clear ans CurPath TargetPath

%%
%{
    a serial of nonlinear functions
%}
clc;
a = tic;
try
    close('nlff')
catch
    
end
fprintf('A serial of NonLinear Functions.\n');
sig_a = @(x) (1./(1+exp(-x)));
atan_a = @(x) atan(x);
sinh_a = @(x) sinh(x);
asinh_a = @(x) asinh(x);
fal_a = @(x,alpha,delta) Fal_Func(x,alpha,delta);

p_nl = figure;
p_nl.Name = 'nlff';
% set(p_nl,'Visible','off');

subplot(321)
% fplot(sig_a,[-10 10])
% hold on 
% x1 = -10:0.1:10;
% y1 = fal_a(x1,0.5,2);
% plot(x1,y1)
% hold on 
% fplot(atan_a,[-10 10])
% hold on 
% fplot(sinh_a,[-1 1])
% legend('sigmoid','fal','atan','sinh','asinh')
text(0.2,0.5,'NonLinear Funtion')

subplot(322)
fplot(sig_a,[-10 10])
title('sigmoid')

subplot(323)
x1 = -10:0.1:10;
y1 = fal_a(x1,0.5,2);
plot(x1,y1)
title('fal')

subplot(324)
fplot(atan_a,[-10 10])
title('atan')

subplot(325)
fplot(sinh_a,[-1 1])
title('sinh')

subplot(326)
fplot(asinh_a,[-10 10])
title('asinh')


exist_flag = exist('H:\MatlabFiles\ADRC\Figures\NonLinearView.fig','file');
if ~(exist_flag == 2) && false
    saveas(p_nl,'H:\MatlabFiles\ADRC\Figures\NonLinearView.fig');
    saveas(p_nl,'H:\MatlabFiles\ADRC\Figures\NonLinearView.png');
    winopen('H:\MatlabFiles\ADRC\Figures');
end

toc(a)
clearvars -except ;