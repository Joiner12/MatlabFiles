%% �����̶����ۺ���
clc
close all 
ts=1; % ��ʼʱ��
tp=7; % �ƻ����ʱ�� 7��
Per = zeros(0) ;% ��ɶ�(0,1)
tused = zeros(0); % �Ѿ���ʱ(0,2*tall)
tall = 20;% Ԥ����ʱ20Сʱ
tc = 3;%��ǰ���� �ӿ�ʼ��������
tpedt = tall/(tp-ts);% �ƻ�ÿ����ʱ
tredt = tused/(tc - ts);% ʵ��ÿ����ʱ
cof01 = 1; %ƽ��ִ������Ч��֮�����ֵ����
cof02 = 8.8;% ʵ�����Ϊ(0,10)

Per = linspace(0,1,100);
tused = linspace(0,2*tall,100);

ntemp01 = (tall.*Per +(-1).* tused');
ntemp02 = (tall*tall*(tc - ts))/cof01*(tp - ts)/100;
ntemp03 = ntemp01/ntemp02;
% 
FunEvl = cof02*exp(-ntemp03);

% meshgrid(Per,tused);
surf(Per,tused,FunEvl)
xlabel('per');
ylabel('time used')
zlabel('�����̶�')