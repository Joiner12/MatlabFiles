%% Simulation Lock Function 
clc;clear;close all;
path = 'H:\MatlabFiles\ChildBlocks';
if isequal(pwd,path)
    fprintf('%s\n ',pwd);
else
    cd(path)
end

%% ���Ի����˲�ģ��
close all
clc
data_size = 1000;
input = zeros(0);
out = zeros(0);

for ki=1:1:data_size
     if ki<data_size/5 
        input(ki) = 0;
    else
        input(ki) = 10 + 5*rand;
    end  
end
figure('name','input')
plot(input)

global initflag;
initflag = 1;

for i=1:1:length(input)
    out(i)=SliderFilter(input(i),5,initflag);
    if isequal(initflag,1)
        initflag = 0;
    end
end

figure('name','f**k your love')
plot(input)
hold on 
plot(out)
grid on
legend('input','out')

%% Deceleration 
%{
	���ٹ����ٶ���������ٶ�������Ӽ��ٶ�������˶�����
%}
% nL = rand*10;% ����������پ���
clc;close all;
Acc = 1; 				%mm/s^2
MaxSpeed = 30; 			% m/s
preSpeed = 1000*rand; 	% ��ʼ�ٶ�
decTime = preSpeed/Acc; % rand V_0
CurSpeed = 0; 			% ��ǰ�ٶ�
outSpeeds = zeros(0);   % �����ٶ�
outAcc = zeros(0);      % ���̼��ٶ�
outJerk = zeros(0); 	% ���̼Ӽ��ٶ�
outDis = zeros(0);  	% �����˶�����
global initflag_1;
initflag_1 = 1;
preAcc = 0;
dir = 0; 
if preSpeed > 0
	dir = 1;
else
	dir = -1;
end
% acc(t) != Acc always
OpCnt = 1;              % Operation Counter
while abs(preSpeed) > 0.1 % almost stop 
    % ���ٶ�ƽ���˲�
	accReal = 0;
    if decTime > 0
		accReal = Acc;
		decTime = decTime - 1;
    end
	
    CurAcc = SliderFilter(accReal,20,initflag_1);
    if isequal(initflag_1,1)
        initflag_1 = 0;
    end
    
    CurSpeed = preSpeed - CurAcc;
    
    % track pre control loop speed
    outSpeeds(OpCnt) = preSpeed;
    outAcc(OpCnt) = CurAcc;
    
    if OpCnt<=1
        outJerk(OpCnt) = CurAcc - 0;
    else
        outJerk(OpCnt) = CurAcc - preAcc;
    end
    outDis(OpCnt) = sum(outSpeeds);

    preSpeed = CurSpeed;
    preAcc = CurAcc;
    OpCnt = OpCnt + 1;
	
end

figure('name','I got a plan t')
subplot(4,1,1)
plot(outSpeeds)
title('Process speed')

subplot(4,1,2)
plot(outAcc)
title('Process Acc')

subplot(4,1,3)
plot(outJerk)
title('Process Jerk')

subplot(4,1,4)
plot(outDis)
title('Process Distance')