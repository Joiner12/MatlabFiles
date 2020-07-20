%% simulation of sigmoid integration
%{
    'H:\MatlabFiles\InterPre\Sripts' = pwd
%}
clc;
%error = rand(100,1) ;
error = linspace(10,0,100);
sigmoidcof =  exp(1.*(error - 5)) + exp(-1.*(error - 5));
sigmoidcof = 1./ sigmoidcof;
integ = zeros(0);
final =  zeros(0);
for i=1:1:length(error)
    temp = sum(error(1:i));
    integ(i) = temp*sigmoidcof(i); 
    final(i) = sum(integ);
end
close all
figure
subplot(2,1,1)
plot(error,integ)
title('瞬时积分')
grid on
subplot(2,1,2)
plot(error,final)
title('积分输出')
grid on

%% 三角形
clc;close all;
scopesize = 10;
k = -2/scopesize;
error = linspace(scopesize,0,100);
yout = k.*abs(error - scopesize/2);
figure
plot(error,yout)
grid on
title('Triangle')

%% 
clc;close all;
x = linspace(0,10,500);
y1 = exp(x);
figure('name','e')
plot(x,y1)

