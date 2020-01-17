clc;
clear;
tic;
x1=0;
y1=0;
r=1;
t1=2000;
t2=50;
ltr=48;
pct=0.99;
stp=1:2*ltr;
tht=2*pi/ltr;
flg=(-1).^stp'*(1-pct)/2+(1+pct)/2;
bdr=[flg.*cos(stp'.*tht/2),flg.*sin(stp'.*tht/2)];
figure;
for itrt=1:4
    a1=2*pi*rand(t1,1);
    a2=2*pi*rand(t2,1);
    u1=rand(t1,1).^(0.5*rand(t1,1).^2);
    u2=sqrt(rand(t2,1));
    x=[(u1*r).*cos(a1)+x1;
    (u2*0.5*r).*cos(a2)+x1];
    y=[(u1*r).*sin(a1)+y1;
    (u2*0.5*r).*sin(a2)+y1];
    P=[x,y,abs(atan(y./x)/tht-round(atan(y./x)/tht))/30,sqrt(x.^2+y.^2)];
    P=P(P(:,4)+P(:,3)<1,:);
    handle=voronoi(delaunayTriangulation(P(:,1:2)));
    hold on;
    set(handle,'Color',[15/255 49/255 96/255],'Marker','none');
    axis equal;
    axis off;
    set(gcf,'Color',[245/255 245/255 245/255]);
end
patch(bdr(:,1),bdr(:,2),'-','FaceColor','none','EdgeColor','r');
axis equal;
axis off;
set(gcf,'Color',[245/255 245/255 245/255]);
hold off;
% saveas(gcf,'CPHG','pdf');
toc;