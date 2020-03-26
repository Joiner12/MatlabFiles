%% doge
clc;
fprintf('时间是让人猝不及防的东西\n');
% 数据计算模块
close all;
global x y c z t el az cnt;
c = imread('Doge.png');
size_c = size(c);
[x,y] = meshgrid(linspace(-10,10,size_c(1)));
R = sqrt(x.^2 + y.^2) + eps;
z = sin(R)./R;
el = 0;
az = 0;
cnt = 0;
figure
mesh(x,y,z,c)
set(gcf,'color','white','numbertitle','off');
str = {'我可能不是人但你是真的狗'};
title(str,'FontSize',18,'Color','red')
t = timer('Period',0.01,'ExecutionMode','fixedRate',...
    'StartDelay',3);
t.TimerFcn = @(~,~)ShineDoge;
start(t);

function ShineDoge()
global x y c z el az cnt;
mesh(x,y,z,c);

cnt =  cnt + 1;
az = 720 - cnt*1.6;
if az < 90
    az = 90;
end

el = -720 + cnt*1.6*1.4 ;
if el > 180
    el = 180;
end
view(el,az);
if cnt > 400
    StopDoge()
end
end

function StopDoge()
global t;
stop(t);
str = {'我可能不是人但你是真的狗'};
title(str,'FontSize',18,'Color','red')
delete(timerfindall);
end