% Created date : 2019年8月26日
clc;
disp('ADRC BLOCK ')
PurposePath = 'D:\Codes\MatlabFiles\ADRC';
if ~strcmp(PurposePath,pwd)
    cd D:\Codes\MatlabFiles\ADRC
end
fprintf('load path...\nt%s\n',pwd)
clear ans

%% 
clc;
T = 1e-3;
s = tf('s');
tf_ob = 16/(s^2 + 0.5*s)
sys = ss(tf_ob);
[num,den] = tfdata(c2d(tf_ob,T,'tustin'),'v');

figure(1)
step(feedback(sys,1))

%% 
%{
    系统模型
    Gp(s) = 0.00011167(s + 33006)/(s^2 + 1.245s)
    reference:
    [1]王永强，张承瑞，滚珠丝杠进给系统仿真建模，振动与冲击，2013，32（03），46-49
%}
clc;
clear;
T = 1e-3;
s = tf('s');
Gs = 0.00011167*(s + 33006)/(s*s + 1.245*s)
[num,den] = tfdata(c2d(Gs,T,'tustin'),'v');
figure(1)
step(feedback(Gs,1))

%% Classical Second Order System
clc;
fprintf('classical second order system\n');
s = tf('s');
ts = 1E-3;
omega = 100;
zeta = 0.2;
Gs = omega^2/(s*s + 2*zeta*s);
DisGs = c2d(Gs,ts,'zoh');
[num,den] = tfdata(DisGs,'v');

figure
if true
    step(Gs)
end
