%% simulator for frog leap down
clc;
startT = tic();
%% config simulator global parameters
global WhileCnt Acc VMax Switch_H SliderScope;
global MAFData t_Reserve;
SliderScope = 1;
Acc = 9.8/1e3*1; % g ¡ú mm/ms^2;
VMax = 30*1000/60/1000; % m/min ¡ú mm/ms
t_Reserve = 1; %reserve decrease time (ms)
MAFData = zeros(SliderScope,1);% Moving average filter
Switch_H = 1;

%% config simlator store varialbles
global MachineryPos Vels_I CapHs Vels_P CalibTableEnable;
global CtrlModes Vels_INofilter CtrlVels Accs;
MachineryPos = zeros(0);
Vels_I = zeros(0);
CapHs = zeros(0);
Vels_P = zeros(0);
CtrlVels = zeros(0);
CalibTableEnable = true;
CtrlModes = zeros(0);
Vels_INofilter =  zeros(0); % no use of filter
Accs = zeros(0);
%% config simlator varialbles
global CurMachinerPos curCapH tarH curV preV;
global Interped OutInterped;
% load Calibration cap sensor Data
if CalibTableEnable
    load('CalibData.mat');
    maxCapH = max(CalibEdge(:,2))*0.01; % calibrate length
else
    maxCapH = 10;
end

CurMachinerPos = 100;
preV = 0; % previous vel(mm/ms)
curCapH = maxCapH; %mm
tarH = 1; %mm
curV = 0;
WhileCnt = 1;
Interped=0;
OutInterped = 0;
%% init local variables
motorCtrlVel = 0;
controlMode = 'interp';
followed = false;
%% follow down main loop
while true && (WhileCnt < 1e3)
    % search fre-h table
    
    if CalibTableEnable
        %curCapH = CapSensor.HeightToCap_V1(CurMachinerPos/0.01,CalibEdge(:,2),CalibEdge(:,1));
        curCapf = CapSensor.HeightToCap_V1(CurMachinerPos/.01,CalibFull(:,2),CalibFull(:,1));
        curCapH = 0.01* CapSensor.CapToHeight_V1(curCapf,CalibFull(:,2),CalibFull(:,1));
    end
    
    switch controlMode
        case 'interp'
            interpCurVel = Mp.InterP_T(preV,curCapH);
            pidCurVel = PidControl(1,tarH - curCapH,0.8);
            curV = interpCurVel;
        case 'pid'
            pidCurVel = PidControl(1,tarH - curCapH,0.8);
            curV = pidCurVel;
        otherwise
            cprintf('error','loading...\n');
    end
    
    % switch controller
    if abs(tarH - curCapH) <= Switch_H  && abs(pidCurVel - interpCurVel) < Acc...
            && contains(controlMode,'interp')
%                 controlMode = 'pid';
    end
    
    %% save process variables
    Accs(WhileCnt) = curV - preV;
    CtrlVels(WhileCnt) = curV;
    CapHs(WhileCnt) = curCapH;
    Vels_I(WhileCnt) = interpCurVel;
    Vels_P(WhileCnt) = pidCurVel;
    MachineryPos(WhileCnt) = CurMachinerPos;
    CtrlModes(WhileCnt) = contains(controlMode,'interp');
    WhileCnt = WhileCnt + 1;
    %% motor
    preV = curV;
    CurMachinerPos = Motor_Model(-1*curV,CurMachinerPos);
    %%
    followed = HasFollowed(abs(tarH - curCapH),0.1,8);
    if CurMachinerPos <= 0 || followed
%         break;
    end
end
cprintf('SystemCommand','Simulator Operation finished. Takes:%0.2f\n',toc(startT));
%%
FigureDownProcess();
cprintf('SystemCommand','Draw figures. Takes:%0.2f\n',toc(startT));