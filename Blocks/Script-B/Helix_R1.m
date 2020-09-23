clc;
ScriptPath = 'H:\MatlabFiles\Blocks';
if ~isequal(ScriptPath,pwd)
    cd(ScriptPath);
end
fprintf("load path: \n%s\n",pwd);

%% fibonacci
clc;
%fibonacci
x = 0;
y = 1;
syms v u

axis off
hold on

for n = 1:8

    a = fibonacci(n);

    % Define squares and arcs
    switch mod(n,4)
        case 0
            y = y - fibonacci(n-2);
            x = x - a;
            eqnArc = (u-(x+a))^2 + (v-y)^2 == a^2;
        case 1
            y = y - a;
            eqnArc = (u-(x+a))^2 + (v-(y+a))^2 == a^2;
        case 2
            x = x + fibonacci(n-1);
            eqnArc = (u-x)^2 + (v-(y+a))^2 == a^2;
        case 3
            x = x - fibonacci(n-2);
            y = y + fibonacci(n-1);
            eqnArc = (u-x)^2 + (v-y)^2 == a^2;
    end

    % Draw square
    pos = [x y a a];
    rectangle('Position', pos)

    % Add Fibonacci number
    xText = (x+x+a)/2;
    yText = (y+y+a)/2;
    text(xText, yText, num2str(a))

    % Draw arc
    interval = [x x+a y y+a];
    p1 = fimplicit(eqnArc, interval,'r','LineWidth',2.5);
end
% saveas(p1,'fibonacci.png')

%% Plot 3-D Alpha Shape and Modify Patch Properties
clc;
t1 = tic;
[x1, y1, z1] = sphere(10);
x1 = x1(:);
y1 = y1(:);
z1 = z1(:);
x2 = x1;
P = [x1 y1 z1; x2 y1 z1];
P = unique(P,'rows');
shp = alphaShape(P,1.5);
plot(shp)
fprintf('%0.1f\n',toc(t1))


%% 阿基米德螺旋线
%{
    https://blog.csdn.net/lanchunhui/article/details/52888463
%}
clc;
close all
alpha = 0.0; 
theta = 0:.1:5*pi;
figure
set(gcf,'color','white', ...
   'numbertitle','off','name','Fractal Fern');
beta = 1;
coef = alpha + beta * theta;

x = coef .* cos(theta);
y = coef .* sin(theta);
p1 = plot(x, y);
p1.LineStyle = '-';
p1.Marker = '<';
p1.MarkerSize = 5;
p1.LineWidth = 1.2;

hold on
grid minor
axis([-15 15 -15 15])
axis off 
saveas(gca,'aki.png')

%% edge line
clc;close all
fprintf('edge line\n')
figure
s = [1 1 1 1 2 2 3 4 4 5 6];
t = [2 3 4 5 3 6 6 5 7 7 7];
weights = [50 10 20 80 90 90 30 20 100 40 60];
G = graph(s,t,weights);
LWidths = 5*G.Edges.Weight/max(G.Edges.Weight);
plot(G,'EdgeLabel',G.Edges.Weight,'LineWidth',LWidths);
saveas(gca,'edge.png')

%% Sinc
clc;


t = 1:10;
x = randn(size(t))';
ts = linspace(0,2*pi,1200);
[Ts,T] = ndgrid(ts,t);
y = sinc(Ts)*x;

figure
set(gcf,'color','white', 'numbertitle','off');
% set(gca,'XColor','none','YColor','none')
p1 = plot(wa2(1:600));
p1.LineWidth = 5;
% xlabel Time, ylabel Signal
% legend('Sampled','Interpolated','Location','SouthWest')
legend off
box off
