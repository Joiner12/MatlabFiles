% Created date : 2019��8��20��
clc;
disp('ADRC BLOCK ')
PurposePath = 'D:\Codes\MatlabFiles\ADRC';
if ~strcmp(PurposePath,pwd)
    cd D:\Codes\MatlabFiles\ADRC
end
fprintf('load path...\nt%s\n',pwd)
clear ans

%%
%{
    Linear Quadratic Regulator Control(LQRC)
    ���ʵ�����Զ��ε�����


    Reference:��Analysis of Control System Models 
        with Conventional LQR and Fuzzy LQR Controller��
%}
% ���ض���
num = [1];
den = [1 5 3];
G = tf(num,den)
[A,B,C,D] = tf2ss(num,den);
co = ctrb(A,B);
ob = obsv(A,C);
% �ɿ���
if length(co) == rank(co)
    fprintf('rank:%d,�ɿ�\n',rank(co));
else
    fprintf('rank:%d,���ɿ�\n',rank(co));
end

% �ܹ���
if length(ob) == rank(ob)
    fprintf('rank:%d,�ɹ�\n',rank(ob));
else
    fprintf('rank:%d,���ɹ�\n',rank(ob));
end

Q = diag([1,1]);
R = 0.1*diag([1]);
K = lqr(A,B,Q,R)