%% 扩张观测器设计（Extened  Status Observor）
% reference:https://blog.csdn.net/song430/article/details/88635542
clear all;
h=0.01;
T=0.01;
time = 20;
N = time/T;
n=0:N-1;
% x = sin(n*T);
x1 = zeros(0);
x2 = zeros(0);
z1 = zeros(0);
z2 = zeros(0);
e = zeros(0);

for k=1:1:N
    %%% original state
    x1(1) = 0;
    x2(1) = 0;
    x1(k+1) = x1(k) + h*x2(k);
    x2(k+1) = x2(k) + h*(-(1+0.5*cos(k*T))*x1(k)-(1+sin(k*T/3))*x2(k)+sign(sin(1.5*k*T)));
    y(k) = x1(k);
    %%%% state observer
    z1(1) = 0;
    z2(1) = 0;
    e(k) = z1(k) - y(k);
    fe = fal(e(k), 0.5, 0.01);
    z1(k+1) = z1(k) + h*(z2(k)-100*e(k));
    z2(k+1) = z2(k) -h*200*fe;
end
figure
plot(n*T,x1(1,1:2000),'b',n*T,z1(1,1:2000),'r');
grid on 
legend('原始状态','观测状态')

% fal函数如下：
function fe = fal(e,tau1,tau2)
    if abs(e)>tau2
        fe = power(abs(e),tau1)*sign(e);
    else
        fe = e/(power(tau2,tau1));
    end
end
