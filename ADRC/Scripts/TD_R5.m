%% 分析数据使用—CDT
clc;
% LogValue(_s_nCnt++,_nHeightUnitP,_ntracker,_ndiff,0,0);
fprintf('load data:\n')
origin = load('C:\Users\Whtest\Desktop\from33A.txt');
tick = origin(:,1);
height = origin(:,2);
% tracker = origin(:,3) + 1.9e5;
tracker = origin(:,3);
ndiff = origin(:,4);
fprintf('figure...\n')
figure('name','track')
subplot(211)
plot(tick,height)
hold on 
plot(tick,tracker)
legend('height','tracker')

subplot(212)
plot(tick,ndiff)

%% 数据分析使用———ESO
% LogValue(_s_nCnt++,_nHeightUnitP,_nCtrlPre,_nMotorOutUnitP,_pESO->x_1,_pESO->x_2,_pESO->x_3);
fprintf('load data:\n')
origin = load('C:\Users\Whtest\Desktop\from33A.txt');
tick = origin(:,1);
height = origin(:,2);
CtrlPre = origin(:,3);
MotorOut = origin(:,4);
State1 = origin(:,5);
State2 = origin(:,6);
State3 = origin(:,7);

try
    close('track');
    close('state');
catch
end
fprintf('figure...\n')
figure('name','track')
subplot(211)
plot(tick,height)
hold on 
plot(tick,State1)
legend('capheight','State1')

subplot(212)
plot(tick,State1)
hold on 
plot(tick,State2)
hold on 
plot(tick,State3)
legend('1','2','3')

figure('name','state')
plot3(State1,State2,State3)
hold on 
plot3(0,0,0,'*')
grid minor


%% 


