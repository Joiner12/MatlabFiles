%% 
ScriptPath = 'D:\Codes\MatlabFiles\Blocks';
if ~isequal(ScriptPath,pwd)
    cd(ScriptPath)
end
fprintf('load path:%s\n',pwd);
%%
%{
    设计思路：
    1.随机球
%}
clc;
close all;
OpCnt = 0;
figure(1)
cur_point = [0 0];
pre_point = [0 0];
axis([-10 10 -10 10])
axis('off')
hold on
ball = line(cur_point(1), cur_point(1), 'Color', 'b', 'LineWidth', ...
    1,'MarkerSize',20,'Marker','o', 'LineStyle', '-','MarkerFace','g');

while OpCnt < 5000
    if OpCnt==1
        pause
    end
    cur_point(1) = rand*20 - 10;
    cur_point(2) = rand*20 - 10;
    set(ball,'XData',cur_point(1),'YData',cur_point(2));
    OpCnt = OpCnt + 1;
    line([cur_point(1) pre_point(1)],[ cur_point(1) pre_point(2)],'LineWidth',0.5,'LineStyle','--')
    hold on
    pre_point(1) =   cur_point(1);
    pre_point(2) =   cur_point(2);
    pause(0.00001)
    fprintf('运行次数%d\n',OpCnt);
end
set(ball,'XData',0,'YData',0);