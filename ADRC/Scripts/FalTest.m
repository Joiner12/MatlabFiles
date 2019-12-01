%% PATH
ScriptPath = 'H:\MatlabFiles\ADRC\Scripts';
cd(ScriptPath)
fprintf('load path:%s...\n',pwd);

%% 
%{
    %---------------测试函数Fal函数----------------%
    测试不同系数对于fal函数的影响
%}
clc;
t = linspace(-2*pi,2*pi,100);
Sgn_Line = linspace(0,1,100);

figure(1)
plot(Sgn_Line,'LineWidth',2,'LineStyle','--')
hold on
for alpha = 0:0.2:2
    for delta = 0:0.2:1
        falOutLine = falOrigin(Sgn_Line,alpha,delta);
        plot(falOutLine,'LineWidth',2)
        fprintf('parameters@alpha %d, @delta %d\n',alpha,delta);
        pause(1);
        hold on
    end
end
grid minor