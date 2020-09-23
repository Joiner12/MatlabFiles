% 使用patch对曲线中间进行颜色填充
% 数据处理
%{
    要求对两条曲线相间部分进行上色。
    使用数组逻辑处理生成由两条曲线坐标围成区域的坐标
%}
clc;
t = 0:0.1:2*pi;
y1 = 5.*sinc(t);
y2 = sinc(t);
upLine = y1;
downLine = y1;
upLine(y1 < y2) = y2(y1 < y2); % 使用数组逻辑运算找出index(时间)下y1,y2较大的值
downLine(y1 > y2) = y2(y1 > y2);% 使用数组逻辑运算找出index(时间)下y1,y2较小的值
patchX = [t,fliplr(t)];
patchY = [upLine,fliplr(downLine)];
try
    close('patchF')
catch
    fprintf('no such figure\n');
end

% 绘图
figure('name','patchF')
subplot(211)
plot(t,y1)
hold on 
plot(t,y2)
grid minor

subplot(212)
plot(t,y1,'LineWidth',4,'LineStyle','-.')
hold on 
plot(t,y2,'LineWidth',4,'LineStyle','-.')
hold on 
patch(patchX,patchY,'green')
grid minor
