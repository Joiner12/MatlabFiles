%% 
clc;
ScriptPath = 'D:\Codes\MatlabFiles\Blocks';
cd(ScriptPath)
fprintf('����·��:%s\n',pwd);

%% ����kalman.h .c
%{
    ��ȡ��������
%}
clc;
datapath = 'D:\Codes\VsProjects\LeetCode\LeetCode';
filename = 'kalman.txt';
file = strcat(datapath,'\',filename);

origin = load(file);
if isequal(length(origin),0)
    warning('���ݵ������');
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

%% ģ�����kalman �˲�
clear
x_true = zeros(0);
N=200;%ȡ200����
w=randn(1,N); 
w(1)=0;
Q=var(w);
v=randn(1,N);
R=var(v);
x_true(1)=0;  % ���ʼ״̬
A=1;    % aΪ״̬ת����
for k=2:N
    x_true(k)=A*x_true(k-1)+ w(k-1); 
end
z = zeros(0);
H=0.2;
z = H.*x_true + v;%���ⷽ�cΪ�������

% x_predict: Ԥ����̵õ���x
% x_update:���¹��̵õ���x
% P_predict:Ԥ����̵õ���P
% P_update:���¹��̵õ���P

%��ʼ����� �� ��ʼλ��
x_update(1)=x_true(1);%s(1)��ʾΪ��ʼ���Ż�����
P_update(1)=0;%��ʼ���Ż�����Э����

for t=2:N
    
    x_predict(t) = A*x_update(t-1); %û�п��Ʊ���

    P_predict(t)=A*P_update(t-1)*A'+ Q;

    K(t)=H*P_predict(t) / (H*P_predict(t)*H'+R);
  
    x_update(t)=x_predict(t)  +  K(t) * (z(t)-H*x_predict(t));
   
    P_update(t)=P_predict(t) - H*K(t)*P_predict(t);
end

t=1:N;
plot(t,x_update,'r',t,z,'g',t,x_true,'b');
legend('kalman','obser','true')