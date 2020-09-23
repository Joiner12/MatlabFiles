%% ≤‚ ‘
% CapHeight[882,2496]
% plot(CapHeight)
close all 
clc
BeforLowPass = CapHeight(882:2496);
myFFT(BeforLowPass,2E-3);
%%
Lowpass = LowPassFilterFun(BeforLowPass,0.2);
myFFT(Lowpass,2E-3);
% ansout = FreObsI(BeforLowPass,2e-3,5);
%% 
CapVirb = CapHeight(649:965);
BeforLowPass = CapVirb;
figure
plot(CapHeight)
hold on 
plot(CapVirb)

%% 
myFFT(CapVirb,2E-3)
Lowpass = LowPassFilterFun(BeforLowPass,0.1);