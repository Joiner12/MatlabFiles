%% 
clc;
ScriptPath = 'D:\Codes\MatlabFiles\Blocks';
cd(ScriptPath)
fprintf('加载路径:%s\n',pwd);

%% 测试kalman.h .c
%{
    获取处理数据
%}
clc;
datapath = 'D:\Codes\VsProjects\LeetCode\LeetCode';
filename = 'kalman.txt';
file = strcat(datapath,'\',filename);

origin = load(file);
if isequal(length(origin),0)
    warning('数据导入出错');
end
time_k = origin(:,1);
real_x = origin(:,2);
obser_x = origin(:,3);
kalman_x = origin(:,4);

figure(1)
p = plot(time_k,real_x,time_k,obser_x,time_k,kalman_x);
p1.LineWidth = 2;
grid on 
legend('real','obser','kalman')

%% 模拟测试kalman 滤波
clear
x_true = zeros(0);
N=200;%取200个数
w=randn(1,N); 
w(1)=0;
Q=var(w);
v=randn(1,N);
R=var(v);
x_true(1)=0;  % 零初始状态
A=1;    % a为状态转移阵
for k=2:N
    x_true(k)=A*x_true(k-1)+ w(k-1); 
end
z = zeros(0);
H=0.2;
z = H.*x_true + v;%量测方差，c为量测矩阵

% x_predict: 预测过程得到的x
% x_update:更新过程得到的x
% P_predict:预测过程得到的P
% P_update:更新过程得到的P

%初始化误差 和 初始位置
x_update(1)=x_true(1);%s(1)表示为初始最优化估计
P_update(1)=0;%初始最优化估计协方差

for t=2:N
    
    x_predict(t) = A*x_update(t-1); %没有控制变量

    P_predict(t)=A*P_update(t-1)*A'+ Q;

    K(t)=H*P_predict(t) / (H*P_predict(t)*H'+R);
  
    x_update(t)=x_predict(t)  +  K(t) * (z(t)-H*x_predict(t));
   
    P_update(t)=P_predict(t) - H*K(t)*P_predict(t);
end

t=1:N;
plot(t,x_update,'r',t,z,'g',t,x_true,'b');
legend('kalman','obser','true')