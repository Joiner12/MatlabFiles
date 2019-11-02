%%
tic
clc
cd D:\Coders\MatlabScrips\KalmanFilter
fprintf('load path\t%s\n',pwd)
clear
N=200;
w=randn(1,N); 
w(1)=0;
Q=var(w); 
v=randn(1,N);%测量噪声
R=var(v);
x_true(1)=0;
A=1;
for k=2:N
    x_true(k)=A*x_true(k-1)+w(k-1); 
end
H=0.2;
z=H*x_true+v;
x_update(1)=x_true(1);
P_update(1)=0;
for t=2:N
    x_predict(t) = A*x_update(t-1); 
    P_predict(t)=A*P_update(t-1)*A'+Q;
    K(t)=H*P_predict(t) / (H*P_predict(t)*H'+R);
    x_update(t)=x_predict(t)  +  K(t) * (z(t)-H*x_predict(t));
    P_update(t)=P_predict(t) - H*K(t)*P_predict(t);
end
figure
t=1:N;
plot(t,x_update,'r',t,z,'g',t,x_true,'b');
grid on
legend('Kalman','Observe','Real') 
toc