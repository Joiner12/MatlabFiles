%% bode figure
clc;
close all;
s = tf('s');
omega = 10;epsilon = 1;
g1 = omega^2/(s^2+2*epsilon*s*omega+omega^2);

figure(1)
hold on 
for i = 0.2:0.5:2.2
    gttemp = omega^2/(s^2+2*i*s*omega+omega^2);
    bode(gttemp)
end

le_1 = {'\epsilon:0.2','\epsilon:0.7','\epsilon:1.2','\epsilon:1.7','\epsilon:2.2',};
leg = legend(le_1,'FontSize',10);
leg.NumColumns  =  2;
grid minor
% return 
figure(2)
hold on 
for omega = 10:20:90
    gttemp = omega^2/(s^2+2*0.7*s*omega+omega^2);
    bode(gttemp)
end
le_2 = {'\omega:10','\omega:30','\omega:50','\omega:70','\omega:90'};
leg = legend(le_2,'FontSize',10);
leg.NumColumns  =  3;
grid minor


