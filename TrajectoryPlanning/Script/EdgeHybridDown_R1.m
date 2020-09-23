%% simulator for frog leap down
clc;clear;
% clearvars -except CalibEdge CalibFull;
global WhileCnt;
% simudata = cell(0);
MachineryP = zeros(0);
Vels = zeros(0);
CapHs = zeros(0);
acc = 9.8/1e3.*1; % g �� mm/ms^2
acc_M = acc;
maxV = 0.5; % mm/ms
curV = 0;
CurMachinerPos = 100;
preCh = 0;
preEh = 0;
WhileCnt = 1;
while true
    MachineryP(WhileCnt) = CurMachinerPos;
    Vels(WhileCnt) = curV;
    tarL = CurMachinerPos;
    %function c = HeightToCap_V1(Cur_h,heights,caps)
    %function h = CapToHeight_V1(CurCap,heights,caps)
    if true
        edgeCap = CapSensor.HeightToCap_V1(CurMachinerPos/0.01,CalibEdge(:,2),CalibEdge(:,1));
    else
        edgeCap = CapSensor.HeightToCap_V1(CurMachinerPos/0.01,CalibFull(:,2),CalibFull(:,1));
    end
    capH = CapSensor.CapToHeight_V1(edgeCap,CalibFull(:,2),CalibFull(:,1));
    capH = capH*0.01;
    CapHs(WhileCnt) = capH;
    % Trapezoidal velocity planning
    Cbias = 1;
    BiasCapH = capH/Cbias;
    [curV,~] = Mp.Interplt(acc_M,maxV,curV,BiasCapH,5,1);
    CurMachinerPos = CurMachinerPos - curV;
    if WhileCnt > 1
        deltaC = abs(capH - preCh);
        deltaE = abs(preEh - CurMachinerPos);
        Cbias = CapBias(curV,deltaC);
    else
        Cbias = 1;
    end
    
    if (CurMachinerPos <= 0 || WhileCnt > 1e4)
        WhileCnt =  WhileCnt + 1;
        CurMachinerPos = 0;
        MachineryP(WhileCnt) = CurMachinerPos;
        Vels(WhileCnt) = curV;
        break;
    end
    preCh = capH;
    preEh = CurMachinerPos;
    WhileCnt =  WhileCnt + 1;
end


%% figure
tcf('edgeDown');
figure('name','edgeDown');
subplot(211)
plot(linspace(0,length(MachineryP)-1,length(MachineryP)),MachineryP)
hold on
plot(linspace(0,length(CapHs)-1,length(CapHs)),CapHs)
set(get(gca, 'XLabel'), 'String', 'steps(ms)');
set(get(gca, 'YLabel'), 'String', 'remL(mm)');
ModifyCurFigProperties();

subplot(212)
plot(linspace(0,length(Vels)-1,length(Vels)),Vels)
set(get(gca, 'XLabel'), 'String', 'steps(ms)');
set(get(gca, 'YLabel'), 'String', 'velocity(mm/ms)');
ModifyCurFigProperties();
%{
subplot(231)
plot(linspace(0,length(MachineryP_1)-1,length(MachineryP_1)),MachineryP_1)
hold on
plot(linspace(0,length(CapHs_1)-1,length(CapHs_1)),CapHs_1)
ModifyCurFigProperties()
set(get(gca, 'XLabel'), 'String', 'steps(ms)');
set(get(gca, 'YLabel'), 'String', 'remL(mm)');
set(get(gca, 'Title'), 'String', '�����岹����');
legend({'����߶�','���ݸ߶�'})


subplot(234)
plot(linspace(0,length(Vels_1)-1,length(Vels_1)),Vels_1)
ModifyCurFigProperties()
set(get(gca, 'XLabel'), 'String', 'steps(ms)');
set(get(gca, 'YLabel'), 'String', 'velocity(mm/ms)');

subplot(232)
plot(linspace(0,length(MachineryP_2)-1,length(MachineryP_2)),MachineryP_2)
hold on
plot(linspace(0,length(CapHs_2)-1,length(CapHs_2)),CapHs_2)
ModifyCurFigProperties()
set(get(gca, 'XLabel'), 'String', 'steps(ms)');
set(get(gca, 'YLabel'), 'String', 'remL(mm)');
set(get(gca, 'Title'), 'String', '��Ե�岹����');
legend({'����߶�','���ݸ߶�'})

subplot(235)
plot(linspace(0,length(Vels_2)-1,length(Vels_2)),Vels_2)
ModifyCurFigProperties()
set(get(gca, 'XLabel'), 'String', 'steps(ms)');
set(get(gca, 'YLabel'), 'String', 'velocity(mm/ms)');

subplot(233)
plot(linspace(0,length(MachineryP_1)-1,length(MachineryP_1)),MachineryP_1)
hold on
plot(linspace(0,length(MachineryP_2)-1,length(MachineryP_2)),MachineryP_2)
ModifyCurFigProperties()
legend({'����','��Ե'})
set(get(gca, 'XLabel'), 'String', 'steps(ms)');
set(get(gca, 'YLabel'), 'String', 'remL(mm)');
set(get(gca, 'Title'), 'String', '��Ե|�����岹���¶Ա�');

subplot(236)
plot(linspace(0,length(Vels_1)-1,length(Vels_1)),Vels_1)
hold on
plot(linspace(0,length(Vels_2)-1,length(Vels_2)),Vels_2)
ModifyCurFigProperties()
set(get(gca, 'XLabel'), 'String', 'steps(ms)');
set(get(gca, 'YLabel'), 'String', 'velocity(mm/ms)');
%}