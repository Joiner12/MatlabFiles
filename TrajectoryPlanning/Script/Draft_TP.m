clc;
clear;
%初始条件
x_arry=[0,10,20,30];
v_arry=[2,2,2];
A_arry=[3,3,3];
pos=[x_arry(1)];
vel=[0];
stepT=[0];
timeall=0;
acc = [0];

for i=1:1:length(x_arry)-1
%清空
    a=[];v=[];s=[];
%计算加减速段的时间和位移
    L=x_arry(i+1)-x_arry(i);
    A=A_arry(i);
    vs=v_arry(i);
    Ta=sqrt(vs/A);
    L1=A*(Ta^3)/6;
    L2=A*(Ta^3)*(5/6); 
%计算整段轨迹的总位移
    T=4*Ta+(L-2*L1-2*L2)/vs;
    for t=0:0.001:T
        if t<=Ta;%加加速度阶段
            ad=A*t;
            vd=0.5*A*t^2;
            sd=(1/6)*A*t^3;
            a=[a,ad];v=[v,vd];s=[s,sd];
        elseif t>Ta && t<=2*Ta;%加减速阶段
            ad=-A*(t-2*Ta);
            vd=-0.5*A*(t-2*Ta)^2+A*Ta^2;
            sd=-(1/6)*A*(t-2*Ta)^3+A*Ta^2*t-A*Ta^3;
            a=[a,ad];v=[v,vd];s=[s,sd];
         elseif t>2*Ta && t<=T-2*Ta;%匀速阶段
            ad=0;
            vd=vs;
            sd=A*Ta^2*t-A*Ta^3;  
            a=[a,ad];v=[v,vd];s=[s,sd];
        elseif t>T-2*Ta && t<=T-Ta;%减加度阶段
            ad=-A*(t-(T-2*Ta));
            vd=-0.5*A*(t-T+2*Ta)^2+A*Ta^2;
            sd=-(1/6)*A*(t-T+2*Ta)^3+A*Ta^2*t-A*Ta^3;
            a=[a,ad];v=[v,vd];s=[s,sd];
         elseif t>T-Ta && t<=T;%减减阶段
            ad=A*(t-T);
            vd=0.5*A*(t-T)^2;
            sd=(1/6)*A*(t-T)^3-2*A*Ta^3+A*Ta^2*T;
            a=[a,ad];v=[v,vd];s=[s,sd];
        end
    end
%时间
    time=[timeall:0.001:timeall+T];
    timeall=timeall+T;
%连接每一段轨迹
    pos=[pos,s(2:end)+x_arry(i)];
    vel=[vel,v(2:end)];
    acc=[acc,a(2:end)];
    stepT=[stepT,time(2:end)];
end
tcf('double s');
figure('name','double s');
subplot(4,1,1),plot(stepT,pos);xlabel('t'),title('position');grid on;ModifyCurFigProperties();
subplot(4,1,2),plot(stepT,vel);xlabel('t'),title('velocity');grid on;ModifyCurFigProperties();
subplot(4,1,3),plot(stepT,acc);xlabel('t'),title('accelerate');grid on;ModifyCurFigProperties();
subplot(4,1,4),plot(stepT(2:end),diff(acc)*1e3);xlabel('t'),title('jerk');grid on;ModifyCurFigProperties();


%%
clc;
Mp.testFunc()

%% just draw figure
a = [0.2 0.3 0.4 0.5 3 8];
b = [0.05 0.118 0.16 0.206 1.61 5.256];
tcf('just draw');
figure('name','just draw');
stem(linspace(1,6,6),a,'filled','LineWidth',4)
hold on
stem(linspace(1,6,6),b,'filled','LineWidth',4)
% for i =1:1:length(a)
%     arrowhead = [a(i),a(i)];
%     arrowtail = [b(i),a(i)];
%     annotation('arrow',arrowhead,arrowtail,'LineStyle','-','color',[1 0 0]);
% %     annotation('arrow',arrowhead,arrowtail,'LineStyle','-','color',[1 0 0]);
% end
set(gca,'XTick',linspace(0,7,8))
set(gca,'XTickLabel',{'0','0.2', '0.3', '0.4',' 0.5', '3' , '8','10'})
set(gca,'YTick',linspace(0,5,8))
set(gca,'YTickLabel',{'0','0.2', '0.3', '0.4',' 0.5', '3' , '8','10'})
set(gca,'XLim',[0 max(a)+1])
ModifyCurFigProperties()
%% 
clc;clear
dataSlider = zeros(100,1);
ins = zeros(0);
ous = zeros(0);
for i = 1:1:1000
    curIn = rand();
%     curIn = int32(curIn);
    [dataSlider,curOut] = MovingFilter_M(dataSlider,curIn,6);
    ins(i) = curIn;
    ous(i) = curOut;
end

tcf('was')
figure('name','was')
plot(ins)
hold on 
plot(ous)

%% 
a = 1;
a = a+ 1