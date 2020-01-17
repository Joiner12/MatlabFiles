%% Minimum Variance Control
clc;
try
    close('MVC');
catch
    
end
fc_1 = @(fre_1,xita_1,t) sin(2*pi*fre_1.*t + xita_1);
fc_2 = @(fre_2,xita_2,t) sin(2*pi*fre_2.*t + xita_2);

t = 0:0.01:10;
y1 = fc_1(1,0,t);
y2 = fc_2(1,pi/6,t);

fig1 = figure();
fig1.Name = 'MVC';
fig1.NumberTitle = 'off';
plot(t,y1,t,y2,t,y2-y1)


%% 
adrc = struct;
adrc.h = 1;
adrc.wh = 1;
adrc.hw = 1;
