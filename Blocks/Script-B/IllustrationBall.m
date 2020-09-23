% sript path
clc;
Scriptpath = 'H:\MatlabFiles\Blocks';
if ~isequal(Scriptpath,pwd)
    cd(Scriptpath)
end
fprintf('script path : %s\n',pwd);

%%
%{
    ���˼·��
    1.ģ����ת�����в�ͬ�ܲ��˶��켣
    2.Ѱ�ҹ켣����
%}
clc;clear;
disp('Illustration tube')
figure(1);%���庯��
axis([-5,5,-5,5]);%���ƶ�άͼ��
hold on;%���ֵ�ǰͼ�μ���ϵ���е�����
axis('off');%��������̶ȣ�����䱳��
%ͨ�������̨�׼����ߵĵ���
head = line(-5,1,'color','k','linestyle','-.','Marker','o', 'MarkerSize',10,'MarkerFace','y');%���õ�
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
    fprintf('ѭ������:%d\n',cnt);
end

