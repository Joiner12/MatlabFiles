% Created date : 2019Äê8ÔÂ26ÈÕ
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
[num,den] = tfdata(c2d(tf_ob,T,'zoh'),'v')
