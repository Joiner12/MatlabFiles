% sript path
clc;
Scriptpath = 'H:\MatlabFiles\Blocks';
if ~isequal(Scriptpath,pwd)
    cd(Scriptpath)
end
fprintf('script path : %s\n',pwd);

%%
clc;
close all
figure
rectangle('Position',[1 120 680 40],'FaceColor','w','EdgeColor','c','LineWidth',2)
xlim([0 700])
ylim([0 480])
hold on
rectangle('Position',[40 120 40 40],'FaceColor','r')
t1 = text(50,100,'\leftarrow×¢ÊÍ');
t1.FontSize = 12;
t1.FontWeight = 'bold';
t1.Rotation = -10;