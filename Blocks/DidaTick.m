%% filepath
clc;
fprintf("load path:%s\n",pwd);
ScirptPath = 'D:\Codes\MatlabFiles\Blocks';
if ~isequal(pwd,ScirptPath)
    cd(ScirptPath);
end

%%
%{
    时钟
    reference:https://blog.csdn.net/tengweitw/article/details/21468723
%}
%%%%%%%%%%%%%%%设置图像属性并获取图像句柄%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=figure('name','我的时钟','NumberTitle','off','color',[1 1 0]);
set(h,'menubar','none','position',[200,200,400,450]);
%%%%%%%%%%%%画出时钟的外轮廓%%%%%%%%%%%%%%
s1=[0:pi/1000:2*pi];
hl=plot(2*cos(s1),2*sin(s1),'black','linewidth',1.5);
axis equal
title('我的时钟');
hold on
%%%%%%%%%%%绘制表盘刻度%%%%%%%%%%%%%%%%%%
for n=pi*2:-pi/30:pi/30              %绘制表盘，绘制分钟的刻度
    a1=0.95*cos(n):0.000005*cos(n)/2:cos(n);b1=0.95*sin(n):0.000005*sin(n)/2:sin(n);
    plot(2*a1,2*b1,'r-');
end
for n=pi*2:-pi/6:pi/30               %绘制表盘，绘制小时的刻度
    a1=0.9*cos(n):0.1*cos(n)/2:cos(n);b1=0.9*sin(n):0.1*sin(n)/2:sin(n);
    plot(2*a1,2*b1,'r-');
end
text(1.5,0,'3','FontSize',12)
text(-0.05,-1.7,'6','FontSize',12)
text(-1.7,0,'9','FontSize',12)
text(-0.1,1.7,'12','FontSize',12)
%%%%%%%%%%%%%%%%获取当前时间并进行角度与弧度转换%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 axis([-2.1 2.1 -2.1 2.1])
     time=datestr(now);
    sec=pi/2-str2num(time(19:20))*pi/30;   
    min=pi/2-(str2num(time(16:17))+sec/60)*pi/30;                                                      
    hour=pi/2-(str2num(time(13:14))+min/60)*pi/6; 
 w1=-pi/30; 
 w2=-pi/1800;  
 w3=-pi/108000; 
 pausetime=1;
 %%%%%%%%%%%%%%%%开始绘图并不断刷新%%%%%%%%%%%%
while 1
    axis off    
    x1=0:0.75*cos(sec)/2:0.75*cos(sec);y1=0:0.75*sin(sec)/2:0.75*sin(sec); %根据秒针的位置绘制分针
    x2=0:0.6*cos(min)/2:0.6*cos(min);y2=0:0.6*sin(min)/2:0.6*sin(min);  %根据分针的位置绘制分针  
    x3=0:0.45*cos(hour)/2:0.45*cos(hour);y3=0:0.45*sin(hour)/2:0.45*sin(hour);  %根据时针的位置绘制分针
    hp1=plot(2*x1,2*y1,'r-','linewidth',1.5);
    hp2=plot(2*x2,2*y2,'b-','linewidth',2);
    hp3=plot(2*x3,2*y3,'g-','linewidth',3.5);
    sec=sec+w1*pausetime;        %计算一秒以后秒针的角度位置
    min=min+w2*pausetime;        %计算一秒以后分针的角度位置
    hour=hour+w3*pausetime;
    pause(1);
    delete(hp1);
    delete(hp2);
    delete(hp3);
end