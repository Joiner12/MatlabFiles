%% 
clc;
disp('ADRC Block')
PurposePath = 'D:\Codes\MatlabFiles\ADRC';
if ~strcmp(PurposePath,pwd)
    cd D:\Codes\MatlabFiles\ADRC
end
fprintf('load path\t>>>>\t%s\n',pwd)
clear ans
%% test for transition process arranging 
trans(10,1,2)

%%  compass 
rng(0,'twister');
M = randn(20,2);
if 0
    M1 = sind(M(:,1));
    M2 = cosd(M(:,2));
    figure
    compass(M1,M2)
else
    close all
    figure
    compass(M(:,1),M(:,2))
    figure 
    scatter(M(:,1),M(:,2))
    grid on
end

%% verify fal
clc;
ts = 1E-3;
fre = 1;
ticks = linspace(0,1,1/ts);
U1 = sin(2*pi.*ticks);
y = zeros(size(U1));

for i = 1:1:length(ticks)
    y(i) = Fal_Func(U1(i),0.5,0.8);    
end
shg;
figure(1)
plot(ticks,y)
hold on 
plot(ticks,U1)
