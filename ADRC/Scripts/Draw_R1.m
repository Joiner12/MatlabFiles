%% 分析数据使用

clc;
% LogValue(_s_nCnt++,_nHeightUnitP,_ntracker,_ndiff,0,0);
fprintf('load data:\n')
origin = load('C:\Users\Whtest\Desktop\ELDT.txt');
tick = origin(:,1);
height = origin(:,2);
% tracker = origin(:,3)+1.9e5;
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
