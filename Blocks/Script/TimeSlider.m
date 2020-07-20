% path
clc;clear;
if ~isequal(pwd,'H:\MatlabFiles\Blocks')
    cd H:\MatlabFiles\Blocks
end
fprintf('load path...\n%s\n',pwd);

%%
%{
    验证不同采样周期下，滑动窗口影响;
%}
clc;
T1 = 5e-4;
T2 = 2*T1;
durationTick = 1; % s
t1 = 0:T1:durationTick;
t2 = 0:T2:durationTick;


