% path
clc;clear;
if ~isequal(pwd,'H:\MatlabFiles\Blocks')
    cd H:\MatlabFiles\Blocks
end
fprintf('load path...\n%s\n',pwd);

%%
%{
    最小二乘算法（Least Squre）
%}
clc;

x = linspace(0,pi,20);
y = 10.*sin(x) + rand(1,20);
p = polyfit(x,y,1)
y1 = polyval(p,x);

y  = zeros(0);
y = erf(x);
if false
figure(1)
plot(x,y,x,y1,'--')
end


% iddata time-domian or frequency-domain