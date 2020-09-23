%% �������¹����У����ݱ仯�������
%{
    �̶��߶����������˶��������ݴ��������߶ȼ�ֹͣ
    ������Ե�����������µĵ��ݱ仯�����
%}
clc;
MachineryPos_0 = 5; % mm
CurMachinerPos = MachineryPos_0;
MachineryPoss = zeros();
AllHeight = cell(0);
Step = 0.1;% mm
global WhileCnt;
WhileCnt = 1;
% preCapH = 0;
while true
    MachineryPoss(WhileCnt)= CurMachinerPos;
    %function c = HeightToCap_V1(Cur_h,heights,caps)
    %function h = CapToHeight_V1(CurCap,heights,caps)
    edgeCap = CapSensor.HeightToCap_V1(CurMachinerPos/0.01,CalibEdge(:,2),CalibEdge(:,1));
    capH = CapSensor.CapToHeight_V1(edgeCap,CalibFull(:,2),CalibFull(:,1));
    capH = capH*0.01;
%     preCapH = capH;
    AllHeight{WhileCnt,1} = capH;
    AllHeight{WhileCnt,2} = CurMachinerPos;
    CurMachinerPos = CurMachinerPos - Step;
    if (CurMachinerPos <= 0 || WhileCnt > 1e4)
        break;
    end
    WhileCnt =  WhileCnt + 1;
end

%%
tcf('edgedown');
figure('name','edgedown');
subplot(311)
plot(cell2mat(AllHeight(:,2)),cell2mat(AllHeight(:,1)));
hold on
plot(cell2mat(AllHeight(:,2)),cell2mat(AllHeight(:,2)));
set(get(gca, 'XLabel'), 'String', '����߶�(mm)');
set(get(gca, 'YLabel'), 'String', '���߶�(mm)');
set(gca,'XDir','reverse');
title('��Ե�̶��߶������˶���ʵ�߶ȺͲ��߶ȶԱ�')
ModifyCurFigProperties();

subplot(312)
temp1 = cell2mat(AllHeight(:,1));
temp2 = cell2mat(AllHeight(:,2));
plot(linspace(5-Step,0,length(temp1)-1),diff(temp1)./diff(temp2));
hold on
plot(linspace(5-Step,0,length(temp1)-1),diff(temp2)./diff(temp2));
set(get(gca, 'XLabel'), 'String', '����߶ȱ仯��(mm/ms)');
set(get(gca, 'YLabel'), 'String', '���߶ȱ仯��(mm/ms)');
set(gca,'XDir','reverse');
ModifyCurFigProperties();

subplot(313)
temp1 = cell2mat(AllHeight(:,1));
temp2 = cell2mat(AllHeight(:,2));
plot(linspace(5-Step,0,length(temp1)-1),diff(temp1) - diff(temp2));
set(get(gca, 'XLabel'), 'String', '����߶ȱ仯��(mm)');
set(get(gca, 'YLabel'), 'String', '���߶ȱ仯��(mm)');
set(gca,'XDir','reverse');
ModifyCurFigProperties();

