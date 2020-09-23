% ʹ��patch�������м������ɫ���
% ���ݴ���
%{
    Ҫ�������������䲿�ֽ�����ɫ��
    ʹ�������߼�����������������������Χ�����������
%}
clc;
t = 0:0.1:2*pi;
y1 = 5.*sinc(t);
y2 = sinc(t);
upLine = y1;
downLine = y1;
upLine(y1 < y2) = y2(y1 < y2); % ʹ�������߼������ҳ�index(ʱ��)��y1,y2�ϴ��ֵ
downLine(y1 > y2) = y2(y1 > y2);% ʹ�������߼������ҳ�index(ʱ��)��y1,y2��С��ֵ
patchX = [t,fliplr(t)];
patchY = [upLine,fliplr(downLine)];
try
    close('patchF')
catch
    fprintf('no such figure\n');
end

% ��ͼ
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
