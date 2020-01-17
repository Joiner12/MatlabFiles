%% 
clc;clear;
TargetPath = 'H:\MatlabFiles\ADRC\Scripts';
CurPath = pwd;
% if CurPath == TargetPath
if ~strcmp(CurPath,TargetPath)
    cd H:\MatlabFiles\ADRC
end
fprintf('Path...\n%s\t\t%s\n',pwd,'-');
clear ans CurPath TargetPath

%% Trajectory planning
%{
    运动轨迹规划方式：
    1.三次曲线规划
    s(t) = 3*t^2/T^2 - 3*t^3/T^3
   
    2.五次曲线规划
    
    3.梯形规划
    
    4.S型规划

    Reference:
    [1]https://blog.csdn.net/fengyu19930920/article/details/81043776
%}
clc;
cubeTpS = @(t,T)3/T^2.*t.^2 - 2/T^3.*t.^3;
cubeTpV = @(t,T)6/T^2.*t - 6/T^3.*t.^2;
cubeTpA = @(t,T)6/T^2 - 12/T^3.*t;
t1 = 0:0.01:1;
y1 = cubeTpS(t1,1);
v1 = cubeTpV(t1,1);
acc1 = cubeTpA(t1,1);
try
    close('cube')
catch
end
figure('name','cube')
subplot(311)
plot(t1,y1)
title('trajectory')

subplot(312)
plot(t1,v1)
title('velocity')

subplot(313)
plot(t1,acc1)
title('accelarator')