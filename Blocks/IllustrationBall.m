% sript path
clc;
Scriptpath = 'H:\MatlabFiles\Blocks';
if ~isequal(Scriptpath,pwd)
    cd(Scriptpath)
end
fprintf('script path : %s\n',pwd);

%%
%{
    设计思路：
    1.模拟旋转过程中不同管材运动轨迹
    2.寻找轨迹补偿
%}
clc;clear;
disp('Illustration tube')
figure(1);%定义函数
axis([-5,5,-5,5]);%绘制二维图形
hold on;%保持当前图形及轴系所有的特性
axis('off');%覆盖坐标刻度，并填充背景
%通过填充绘出台阶及两边的挡板
head = line(-5,1,'color','k','linestyle','-.','Marker','o', 'MarkerSize',10,'MarkerFace','y');%设置点
cur_point = [0,0];
pre_point = [0,0];
cnt = 1;
while cnt <  1000
    x = rand*10 - 5;
    y = rand*10 - 5;
    cur_point(1) = x;
    cur_point(2) = y;
    set(head,'xdata',x,'ydata',y);
    faceColor = ['b','c','g','r','y','k'];
%     set(head,'MarkerFace',faceColor(rem(rand*10 + 1,6)))
    pause(0.0001)
    cur_line = line(cur_point,pre_point);
    cur_line.LineWidth = 2;
    cnt = cnt + 1;
    pre_point(1) = x;
    pre_point(2) = y;
    drawnow;
%     pause;
    fprintf('循环次数:%d\n',cnt);
end

