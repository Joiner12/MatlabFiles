%%  path
clc;
Filepath = 'D:\Codes\MatlabFiles\ADRC';
cd (Filepath)

%% 非线性函数-01
%{
sat(x,δ)饱和函数
%}
clc;
x = linspace(-10,10,200);
y = zeros(0);
delta = 5;
for i = 1:1:length(x)
    if abs(x(i)) >= delta
        y(i) = sign(x(i));
    else
        y(i) = x(i)/delta;
    end
end

figure
plot(x,y,'linewidth',2)

%% 非线性函数-02
% fal(x,а，δ)
clc;
delta = 1;
alfalfa = 3;

x = linspace(-10,10,200);
y = zeros(0);
for i=1:1:length(x)
   if abs(x(i)) >=  delta
       temp =  abs(x(i));
       temp = temp^alfalfa;
       y(i) = temp*sign(x(i));
   else
       y(i) = x(i)/(delta)^(1-alfalfa);
   end
end

figure
plot(x,y)