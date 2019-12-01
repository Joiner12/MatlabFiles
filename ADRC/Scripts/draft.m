%
clc;
clear;
fprintf('this is fucking awesome\n');
a = [1,2,3]
b = [1;2;3]

%% 
clc;
clear;
s = tf('s');
ts = 1e-3;
w0 = 20;
selong = 0.5;
gain_fun = 80;
Gs = gain_fun/(s^2 + 2*selong*w0*s + w0^2)
c2d(Gs,ts,'zoh')
[num_M,den_M] = tfdata(c2d(Gs,ts,'zoh'),'v')
fprintf('transfor function\n')


%% 
% 匿名函数
clc;
f_handle = @(x) sin(x);
plot(f_handle(linspace(0,pi,10)))


%% 
clc;
close all
s = tf('s');
t = 1e-3;
kesai = 0.1;
omega = 100;
figure
for i = 1:-0.1:0.1
    Gs = omega*omega/(s*s + 2*i*omega*s + omega*omega);
    bode(Gs)
    hold on
end
% Gs = 1/(0.01*t*s + 1);
fb = bandwidth(Gs)

%% 
clc;
close all;
a = 1:-0.1:0.1;
b = - 20.*log10(a);

figure
set(get(gca, 'XLabel'), 'String', 'rad');
set(get(gca, 'YLabel'), 'String', 'db');
plot(a,b)

%% test NLSEF function
clc;
ts = 1e-3;
sigfre = 1;
z1 = zeros(0);
z2 = zeros(0);
t = linspace(0,1/sigfre,1/ts + 1);
z1 = sin(2*pi*sigfre.*t);
z2 = diff(z1);
% z1 = rand(size(t))*0.5 - 0.25 +  z1 ;
z2 = [z2,z1(end)];
y = zeros(0);
U = zeros(1,2);
beta1 = [1,1];

for i = 1:1:length(z1)
    U = [z1(i),z2(i)];
    
    y(i) = NLSEF_R1(U,0.5,0.5,beta1(1),0.5,0.5,beta1(2));
end

figure
plot(t,z1)
hold on 
plot(t,z2)
hold on 
plot(t,y)
hold on 
plot(t,yout')
legend('z1','z2','u')


%% signum funciton
clc;
x = linspace(-10,10,21);
y = sign(x);
figure
plot(x,y)

%% This is a draft
clc;
fprintf('this is a real time script...\n');
a = tic ;

while(toc(a) < 10000)
    tick  = mod(int32(str2double(datestr(datetime('now'),'ss'))/5),2) + 1;
    nam = ["A:","B:"];
    fprintf('%s\n',strcat(nam(tick),why_m()));
    pause(1)
end


%%
clc;
close all
fprintf('capheight problems\n');
prob = load('C:\Users\Whtest\Desktop\Machine\Data_Problem.txt');
work = load('C:\Users\Whtest\Desktop\Machine\Data_work.txt');
work_1 = load('C:\Users\Whtest\Desktop\Machine\Data_work_1.txt');
work_2 = load('C:\Users\Whtest\Desktop\Machine\Data_work_2.txt');
work_3 = load('C:\Users\Whtest\Desktop\Machine\Data_work_3.txt');
work_4 = load('C:\Users\Whtest\Desktop\Machine\Data_work_4.txt');
work_5 = load('C:\Users\Whtest\Desktop\Machine\Data_work_5.txt');
% work_6 = load('C:\Users\Whtest\Desktop\Machine\Data_Work_6.txt');
figure('name','capheight')
plot(prob(:,1),prob(:,2)/100,'LineWidth',2,'LineStyle','--')
hold on 
plot(work(:,1),work(:,2)/100)
hold on 
plot(work_1(:,1),work_1(:,2)/100)
hold on 
plot(work_2(:,1),work_2(:,2)/100)
hold on 
plot(work_3(:,1),work_3(:,2)/100)
hold on 
plot(work_4(:,1),work_4(:,2)/100)
hold on 
plot(work_5(:,1),work_5(:,2)/100)
ylabel('高度/mm')
xlabel('电容/hz')
legend('下扎','正常','1','2','3','4','5')
grid minor 

%% 
s = tf('s');
gs = @(R,k1,k2,s) (k1*R^2/(s^2 + k2*R*s + k1*R^2))
% gs =  

%% 
figure(1)
plot(ELDT(:,1),ELDT(:,2))
hold on 
plot(ELDT(:,1),ELDT(:,3))
hold on 
plot(ELDT(:,1),ELDT(:,4))
legend('origin','track','diff')

%% 仿真数据,from workspace 拼接
ELDT_SimData = [(2e-3).*VarName1,VarName2]

