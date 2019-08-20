% Created date : 2019年8月20日
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
    设计实现线性二次调节器


    Reference:《Analysis of Control System Models 
        with Conventional LQR and Fuzzy LQR Controller》
%}
% 被控对象
num = [1];
den = [1 5 3];
G = tf(num,den)
[A,B,C,D] = tf2ss(num,den);
co = ctrb(A,B);
ob = obsv(A,C);
% 可控性
if length(co) == rank(co)
    fprintf('rank:%d,可控\n',rank(co));
else
    fprintf('rank:%d,不可控\n',rank(co));
end

% 能观性
if length(ob) == rank(ob)
    fprintf('rank:%d,可观\n',rank(ob));
else
    fprintf('rank:%d,不可观\n',rank(ob));
end

Q = diag([1,1]);
R = 0.1*diag([1]);
K = lqr(A,B,Q,R)