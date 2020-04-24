clc;
clear;

% ��̬�ֲ�ϵ��
Para1 = [0.05,0.043,0.035,0.032,1,1000,2E11];
Cof_1 = 0.0045;
Para2 = Cof_1.*Para1;

% Para1 = [0.05,0.043,0.035,0.032,1,1000,2E11];
% Para2 = 0.0045*[0.05,0.043,0.035,0.032,1,1000,2E11];

% ��̬�ֲ�
distribution = {'norm','norm','norm','norm','norm','norm','norm'};

%
Nx = length(Para1);
Nt = 100012;  


%{
        ���ɲ������к���:sobol
        matlab�Դ�����:sobol
        matlab ���������鿴�ú������嶨����÷�:
        >> docsearch sobol 
%}
Dp = sobolset(Nx,'Skip',1e3,'Leap',1e2);

for i=1:Nx
    
    %{
        �ֲ�����:icdf
        matlab�Դ�����:icdf
        matlab ���������鿴�ú������嶨����÷�:
        >> docsearch icdf 
    %}
    Xt(:,i) = icdf(distribution{i},Dp(1:Nt,i),Para1(i),Para2(i));
end
count = 0;

% ģ�ͺ���
%{
    y = (4*x(:,6).*x(:,5).^3)./(x(:,7).*(x(:,3).*x(:,1).^3 - x(:,4).*x(:,2).^3));
%}
[y] = g(Xt);

%���ݲ�֣� Xt�����1�е���12������
s = Xt(1:12,:);
%���ݲ�֣� Xt�����13�е������һ������
ss = Xt(13:end,:);

ys = y(1:12,:);
yss = y(13:end,:);

% ����y��ƽ��ֵ
%{ 
    matlab�Դ�������mean
    matlab ���������鿴�ú������嶨����÷�:
    >> docsearch mean 
    
%}
mean_y = mean(y);


return;
save s.mat s;
save ys.mat ys;
save ss.mat ss;
save yss.mat yss;
save mean_y.mat mean_y;


fprintf("���������룬Ȼ��س�\n");