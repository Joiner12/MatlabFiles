%%
clc;
if ~isequal(pwd,'D:\Codes\MatlabFiles\ADRC\Scripts')
    cd('D:\Codes\MatlabFiles\ADRC\Scripts');
end
fprintf('Current Script Path:\n%s\n',pwd);
%%
try
    close('fig1')
    close('fig2')
catch
    
end
f1 = figure('name','fig1');
plot(tout,track(:,1))
hold on
plot(tout,track(:,2))
hold on
plot(tout,track(:,3))
legend('ԭʼ�ź�','����΢�ָ�����','����΢�ָ�����')
grid minor
title('���ٽ���Ա�')

f2 = figure('name','fig2');
plot(tout,diff(:,1))
hold on
plot(tout,diff(:,2))
legend('����΢�ָ�����','����΢�ָ�����')
grid minor
title('΢���źŶԱ�')


%% ʵ�ʲ���ƽ̨��� 1hz
load('D:\Codes\MatlabFiles\ADRC\Scripts\1hz΢��ʵ��Ա�����.mat')
load('D:\Codes\MatlabFiles\ADRC\Scripts\1hz����Ա�.mat')
%%
figure
subplot(211)
plot((VarName1-VarName1(1))/2000,(VarName2-3000)/1000)
hold on
plot((VarName1-VarName1(1))/2000,(VarName3-3000)/1000)
hold on
plot((VarName1-VarName1(1))/2000,(VarName5-3000)/1000)
legend('ԭʼ','ǰ������','���͸���')

subplot(212)
plot((VarName1-VarName1(1))/2000,VarName4)
hold on
plot((VarName1-VarName1(1))/2000,VarName7)
legend('forward','noforward')

%%
clc;
zeropoint = zeros(0);
cnt = 1;
for i=1:length(VarName2)-1
    if (VarName2(i)-3000)/1000 < 0 &&  (VarName2(i+1)-3000)/1000 >0
        zeropoint(cnt) = i;
        cnt = cnt + 1;
    end
end
% ����� 
% [324,632,941,1249,1557,1857,2157,2457,2757]
%% ��һ������
tick_1 = (VarName1-VarName1(1))/2000;
VarName2_1 = (VarName2-3000)/1000;
VarName3_1 = (VarName3-3000)/1000;
VarName5_1 = (VarName5-3000)/1000;

VarName4_1 = (VarName4)/1000;
VarName7_1 = (VarName7)/1000;


figure
subplot(211)
plot(tick_1,VarName2_1)
hold on
plot(tick_1,VarName3_1)
hold on
plot(tick_1,VarName5_1)
legend('ԭʼ','ǰ������','���͸���')
xlabel('time/s');ylabel('height/mm');
grid minor

subplot(212)
plot(tick_1,VarName4_1)
hold on
plot(tick_1,VarName7_1)
legend('forward','noforward')
xlabel('time/s');ylabel('height/mm');
grid minor
% 

%% �������ݴ���
figure
subplot(211)
plot(trackout.time,trackout.data(:,1))
hold on 
plot(trackout.time,trackout.data(:,2))
hold on 
plot(trackout.time,trackout.data(:,3))
legend('����ԭʼ�ź�','����΢�ָ�����','����΢�ָ�����')
title('�����ź�')
grid minor
xlabel('time/s');ylabel('height/mm');
subplot(212)
plot(diffout.time,diffout.data(:,1))
hold on 
plot(diffout.time,diffout.data(:,2))
legend('����΢�ָ�����','����΢�ָ�����')
title('΢���ź�')
grid minor
xlabel('time/s');ylabel('height/mm');

%% final version
%% ʵ�����ݴ���
figure
subplot(211)
p1 = plot((tick_1(324:941) - tick_1(324))/1000,VarName2_1(324:941));
p1.LineWidth = 1;
hold on
p2 = plot((tick_1(324:941) - tick_1(324))/1000,VarName3_1(324:941));
p2.LineWidth = 1;
hold on
p3 = plot((tick_1(324:941) - tick_1(324))/1000,VarName5_1(324:941));
p3.LineWidth = 1;
legend('ԭʼ','ǰ������','���͸���')
title('�����ź�')
grid minor
xlabel('time/s');ylabel('height/mm');
subplot(212)
p4 = plot((tick_1(324:941) - tick_1(324))/1000,VarName4_1(324:941));
p4.LineWidth = 1;
hold on
p5 = plot((tick_1(324:941) - tick_1(324))/1000,VarName7_1(324:941));
p5.LineWidth = 1;
legend('forward','noforward')
grid minor
xlabel('time/s');ylabel('height/mm');
title('΢���ź�')

%% �������ݴ���2
figure
subplot(211)
p6 = plot(trackout.time(1:2000),trackout.data(1:2000,1));
p6.LineWidth =1;
hold on 
p7 = plot(trackout.time(1:2000),trackout.data(1:2000,2));
p7.LineWidth = 1;

hold on 
p8 = plot(trackout.time(1:2000),trackout.data(1:2000,3));
p8.LineWidth  =1;
legend('����ԭʼ�ź�','����΢�ָ�����','����΢�ָ�����')
title('�����ź�')
grid minor
xlabel('time/s');ylabel('height/mm');
subplot(212)
p9 = plot(diffout.time(1:2000),diffout.data(1:2000,1));
p9.LineWidth=1;
hold on 
p10 = plot(diffout.time(1:2000),diffout.data(1:2000,2));
p10.LineWidth=1;
legend('����΢�ָ�����','����΢�ָ�����')
title('΢���ź�')
grid minor
xlabel('time/s');ylabel('height/mm');


