% Created date : 2019��8��26��
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
    ϵͳģ��
    Gp(s) = 0.00011167(s + 33006)/(s^2 + 1.245s)
    reference:
    [1]����ǿ���ų��𣬹���˿�ܽ���ϵͳ���潨ģ����������2013��32��03����46-49
%}
clc;
clear;
T = 1e-3;
s = tf('s');
Gs = 0.00011167*(s + 33006)/(s*s + 1.245*s)
[num,den] = tfdata(c2d(Gs,T,'tustin'),'v');
figure(1)
step(feedback(Gs,1))