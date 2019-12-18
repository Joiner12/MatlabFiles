clc;
if ~isequal(pwd,'H:\MatlabFiles\ADRC\Scripts')
    cd('H:\MatlabFiles\ADRC\Scripts')
end
fprintf('Current Script Path:\n%s\n',pwd)

%% ϵͳ�۲���ѧϰ����
%{
    1.ŷ����÷�������
    2.΢�ֶ�������ģ�ķŴ���������
    3.ϵͳ�ܹۡ��ܿ����о�
    4.���붨��
    5.��ά�۲������
%}

%% ����
clc;
a = randi(10,1,10);
fprintf('ŷ�Ϸ���:%.5f\n',norm(a,2));

%% ϵͳ�ܹ۲�|�ܿ�
% ϵͳ����
clc;
fprintf('control ability & observe ability\n');
A = [0 1; -1,0];
B = [1;0];
C = [1 0];
 
% �ж�ϵͳ�Ƿ���ȫ�ܿ�
E_con = ctrb(A,B);           % ����ܿ��Ծ���
E_val_con = rank(E_con)      % �����ܿ��Ծ����Ƿ������ж��ܿ���

E_obs = obsv(A,C);           % ����ܹ��Ծ���
E_val_obs = rank(E_obs)      % �����ܹ��Ծ����Ƿ������ж��ܹ���


%% ����MATLAB�е�acker�������״̬�۲���
clc ;
% ϵͳ����
A = [0 1; -1,0];B = [1;0];C = [1 0];
% �����ļ���
P = [-2;-2]; 
% �ж�ϵͳ�Ƿ���ȫ�ܹ�
E_obs = obsv(A,C);           
% ����ܹ��Ծ���
E_val = rank(E_obs);         
% �����ܿ��Ծ����Ƿ������ж��ܹ��� 
L_acker = (acker(A',C',P))'
% ����acker��״̬�������L


%% ESO(I)
%{
    [1]Active disturbance rejection control:some recent experimental and industrial case studies
%}
clc;
b0 = 10;
A = [0 1 0;0 0 1;0 0 0]
B = [0;b0;0]
C = [1 0 0]
E = [0;0;1]
D = [0 0 0]
ss(A,B,C,D)


%% ESO(II)
%{
    LESO����ԭ��
    
    [1]Active Disturbance Rejection Control for Nonlinear Systems: An Introduction
%}
