%% 紧急程度评价函数
clc
close all 
ts=1; % 开始时间
tp=7; % 计划完成时间 7天
Per = zeros(0) ;% 完成度(0,1)
tused = zeros(0); % 已经用时(0,2*tall)
tall = 20;% 预计用时20小时
tc = 3;%当前日期 从开始日期算起
tpedt = tall/(tp-ts);% 计划每天用时
tredt = tused/(tc - ts);% 实际每天用时
cof01 = 1; %平衡执行力和效率之间的数值计算
cof02 = 8.8;% 实现输出为(0,10)

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
zlabel('紧急程度')