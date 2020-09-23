%% proof 
tic
clc;
disp('simulation')
Acc = 1; %m/s^2
V_max = 10;% m/s
t_Resv = 0;
SliderScope = 10;
MoveL = 100; %m
run_time = 0;
[tick1,vel1,rem1] = Interpolation(Acc,V_max,0,SliderScope,MoveL);
[tick2,vel2,rem2] = Interpolation(Acc,V_max,5,SliderScope,MoveL);
[tick3,vel3,rem3] = Interpolation(Acc,V_max,10,SliderScope,MoveL);
fprintf('length: %d\t%d\t%d\t\n',sum(vel1),sum(vel2),sum(vel3));
zeropos0 = find(vel1 == 0);
zeropos1 = find(vel2 == 0);
zeropos2 = find(vel3 == 0);
fprintf('tick : %d \t %d \t %d \t\n',0,tick2 - tick1,tick3 - tick1);

if 1
    close all
    figure
    plot(linspace(1,length(vel1),length(vel1)),vel1)
    hold on 
    plot(linspace(1,length(vel2),length(vel2)),vel2)
    hold on 
    plot(linspace(1,length(vel3),length(vel3)),vel3)
    legend('0','5','10')
    disp('finished')
%     figure
%     plot(rem1)
%     hold on 
%     plot(rem2)
%     hold on 
%     plot(rem3)
%     legend('1','2','3')
end
toc

%% 

