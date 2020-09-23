%% 
clc;
AccSet = 1; % g
AccStdSet = 0.12;
VelSet = 30/60; % mm/ms

% MotionState = cell(0);
Vs = VelSet:-1*AccStdSet:0;
Ts = 0:1:(length(Vs)-1);
Ss =( Vs.^2 - power(VelSet,2))./2./AccStdSet;
Ss = Ss - min(Ss);
AccRegs = AccStdSet.*ones(size(Ts));
%{
    Ss = VelSet.*Ts - 0.5.*Ts.^2;
    Ss = Ss - min(Ss);
%}

for i=1:1:length(Ss)
    wrongCof  = 1;
    if i > 30
        wrongCof = 1;      
    end
    RemL = Ss(i).*wrongCof;
    CurVel = Vs(i);
    SetAcc = AccStdSet;
    [AccRegTemp,EnableFlag] = AccRegulator(CurVel,SetAcc,RemL);
    AccRegs(i) = AccRegTemp;
end

% figure
tcf('motion');
figure('name','motion','WindowState','maximized');
subplot(221)
plot(Ss)
ModifyCurFigProperties();

subplot(223)
plot(AccRegs)
ModifyCurFigProperties();

