%% Polyfit 
clc;
syms x a b c;
fth = x/(a*x+b)+c;
f = matlabFunction(fth);
% return
% 
a1 = 1;b1 = 2;c1 = 400;
x1 = 1:1:100;
y1 = f(a1,b1,c1,x1);
tcf('nas')
figure('name','nas')
plot(x1,y1)

%% sample
clc;
rng default % For reproducibility
A = [1,2];
r = [-1,-3];
tdata = 3*rand(200,1);
tdata = sort(tdata); % Increasing times for easier plotting
noisedata = 0.05*randn(size(tdata)); % Artificial noise
ydata = A(1)*exp(r(1)*tdata) + A(2)*exp(r(2)*tdata) + noisedata;
plot(tdata,ydata,'r*')
xlabel 't'
ylabel 'Response'

% To find the best-fitting parameters A and r, 
% first define optimization variables with those names.

A = optimvar('A',2);
r = optimvar('r',2);
% Create an expression for the objective function, which is the sum of squares to minimize.

fun = A(1)*exp(r(1)*tdata) + A(2)*exp(r(2)*tdata);
obj = sum((fun - ydata).^2);

lsqproblem = optimproblem("Objective",obj);
