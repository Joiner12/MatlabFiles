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
t = linspace(-pi,pi,100);
Sgn_Line = linspace(0,1,100);

figure(1)
plot(Sgn_Line,'LineWidth',2,'LineStyle','--')
hold on
for alpha = 0:0.2:2
    for delta = 0:0.2:1
        falOutLine = fal(Sgn_Line,alpha,delta);
        plot(falOutLine,'LineWidth',2)
        fprintf('parameters@alpha %d, @delta %d\n',alpha,delta);
        pause(1);
        hold on
    end
end
grid minor


%% fal函数图形
%{
    2019-12-25：
    1.调用fal函数，观察基本输出图形现象
    2020-1-15：
    2.非线性度函数评价
%}
clc;
x = zeros(0);
y = zeros(0);
% x1 = 
cnt = 1;
for i = -2:0.01:2 
    if abs(i)<1
        temp = Fal_Func(i,0.5,0.2);
        x(cnt) = i;
        y(cnt) = temp;
        y1(cnt) = abs(sin(pi*i));
        y2(cnt) = sin(pi*i)*temp;
        if i > 0
            y3(cnt) = 1;
        else  
            y3(cnt) = -1;
        end
    else
        x(cnt) = i;
        y(cnt) = 1;
        y1(cnt) = abs(sin(pi*i));
        y2(cnt) = sin(pi*i);
        if i > 0
            y3(cnt) = 1;
        else  
            y3(cnt) = -1;
        end
    end
    
    cnt = cnt + 1;
end

try
    close('fal_1')
catch
    
end
figure('name','fal_1')
subplot(311)
plot(x,y,x,y1,x,y2)
subplot(312)
plot(x,y,x,y3)
subplot(313)
plot(x,y3)
