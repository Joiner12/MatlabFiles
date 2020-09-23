%% I'm not the man,meanwhile you are real dog.
clc;
global x;
global y;
global z;
global c;
global cnt;
global el;
global az;
close all;
el = 0;
az = 0;
[c] = imread('C:\Users\Whtest\Desktop\doge.jpg');
% image( c(200:400,100:500))
cnt = 0;
size_c = size(c);
t = timer('Period',0.01,'ExecutionMode','fixedRate','StartDelay',2,... 
    'TasksToExecute',200);
t.TimerFcn = @(~,~)ShineDog;
t.StopFcn = @(~,~)StopTimer;
start(t)

[x,y] = meshgrid(linspace(-10,10,size_c(1)),linspace(-10,10,size_c(2)));
% set(gcf,'ToolBar','none','position',[-1800,10,200,200]);
% set(gcf,'MenuBar','none');
set(gcf, 'numbertitle','off','color','white');

x = x';
y = y';
R = sqrt(y.^2 + x.^2) + eps;
z = sin(R)./R;
mesh(x,y,z,c)

function ShineDog()
cla;
global cnt;
global x;
global y;
global z;
global c;
global el;
global az;
cnt  = cnt + 1;
mesh(x,y,z,c);
el = cnt*0.9/2;
if el > 90
    el = 90;
end
az = cnt*0.9/2;
if az > 180
    az = 180;
end
view(az,el);
end

function StopTimer()
fprintf("I'm not a human,you do be a true dog!\n")
text(0,0,{"I'm not a man",'meanwhile you do be a dog'},'FontSize',15,'Color','red')
delete(timerfindall);
end
