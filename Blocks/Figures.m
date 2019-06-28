%% 
filepath = 'D:\Codes\MatlabFiles\Blocks';
cd (filepath)
%%
% Matlab ¸ß¼¶»æÍ¼
clc;

close all;

x=(0:pi/100:2*pi)';

y1=2*exp(-0.5*x)*[1,-1];

y2=2*exp(-0.5*x).*sin(2*pi*x);

x1=(0:12)/2;

y3=2*exp(-0.5*x1).*sin(2*pi*x1);

plot(x,y1,'k:',x,y2,'b--',x1,y3,'rp');

text(1,1,'turn for what')

box off

% pause(1000)

box on

%program 1

x=0:0.1:2*pi;

[x,y]=meshgrid(x);

z=sin(y).*cos(x);

mesh(x,y,z);

xlabel('x-axis'),ylabel('y-axis'),zlabel('z-axis');

title('mesh'); pause;

%program 2

x=0:0.1:2*pi;

[x,y]=meshgrid(x);

z=sin(y).*cos(x);

surf(x,y,z);

xlabel('x-axis'),ylabel('y-axis'),zlabel('z-axis');

title('surf'); pause;

%program 3

x=0:0.1:2*pi;

subplot(2,2,1);

ezplot('x^2+y^2-9');axis equal;


subplot(2,2,2);

ezplot('x^3+y^3-5*x*y+1/5')

subplot(2,2,3);

ezplot('cos(tan(pi*x))',[0,1]);

subplot(2,2,4);

ezplot('8*cos(t)','4*sqrt(2)*sin(t)',[0,2*pi]);

[x,y]=meshgrid(x);

z=sin(y).*cos(x);

plot3(x,y,z);

xlabel('x-axis'),ylabel('y-axis'),zlabel('z-axis');

title('plot3-1');grid;


