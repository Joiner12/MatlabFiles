Filepath = 'D:\Codes\MatlabFiles\Blocks';
cd(Filepath)


%%

function d = dxdt3(t,x)

d=[ x(2)+x(1)*(2-x(1)^2-x(2)^2);
    -x(1)+x(2)*(2-x(1)^2-x(2)^2) ];
% 根据状态方程，画出变量轨迹：

figure('color','w');
hold on
for theta=[0:20]*pi/10
    x0=3*[cos(theta);sin(theta)];%定义初始值数组
    [t,x]=ode45(@dxdt,[0:0.1:8],x0);
    plot(x(:,1),x(:,2),'linewidth',0.5)
    quiver(x(:,1),x(:,2),gradient(x(:,1)),gradient(x(:,2)),'linewidth',3.0);%增加轨迹方向箭头
end

for theta=[0:2:20]*pi/10
    x0=1e-5*[cos(theta);sin(theta)];
    [t,x]=ode45(@dxdt,[0:0.2:20],x0);
    plot(x(:,1),x(:,2),'linewidth',0.5)
    quiver(x(:,1),x(:,2),gradient(x(:,1)),gradient(x(:,2)),'linewidth',1.5)
    xlabel('x1','FontSize',18,'FontWeight','bold','Color','r');
    ylabel('x2','FontSize',18,'FontWeight','bold','Color','r')
    title('Made by J PAN')
end
end