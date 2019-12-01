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
legend('原始信号','复合微分跟踪器','经典微分跟踪器')
grid minor
title('跟踪结果对比')

f2 = figure('name','fig2');
plot(tout,diff(:,1))
hold on 
plot(tout,diff(:,2))
legend('复合微分跟踪器','经典微分跟踪器')
grid minor
title('微分信号对比')