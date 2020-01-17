ScriptPath = 'H:\MatlabFiles\Blocks';
if ~isequal(ScriptPath,pwd)
    cd(ScriptPath);
end
fprintf("load script path: \n%s\n",pwd);

%% map scatter
clc;clear;
load cellularTowers;
head(cellularTowers);
figure(1)
subplot(221)
geoscatter(cellularTowers.Latitude, cellularTowers.Longitude, '.')
text(gca,37.75,-122.75,'San Francisco','HorizontalAlignment','right')

subplot(222)
geodensityplot(cellularTowers.Latitude, cellularTowers.Longitude)
text(gca,37.75,-122.75,'San Francisco','HorizontalAlignment','right')

subplot(223)
geoscatter(30.00, 128.0, 'r.')
text(gca,30.00, 128.0,'San Francisco','HorizontalAlignment','right')


%% Data from China Earthquake Networks Center
clc;
clear;
fprintf('cellular  Eq.\n');
opts = detectImportOptions('C:\Users\Whtest\Desktop\eqList2019_10_29.txt');
opts.VariableNames = {'Time','Level','Latitude','Longitude','Depth','Position'};
Eq = readtable('C:\Users\Whtest\Desktop\eqList2019_10_29.txt',opts);
%%

scEqStruct = {};
temp_size = size(Eq);
scCnt = 1;
for i=1:1:temp_size(1)
    if contains(Eq.Position(i),{'四川','重庆'})
        scEqStruct(scCnt).Time = Eq.Time(i);
        scEqStruct(scCnt).Level = Eq.Level(i);
        scEqStruct(scCnt).Latitude = Eq.Latitude(i);
        scEqStruct(scCnt).Longitude = Eq.Longitude(i);
        scEqStruct(scCnt).Depth = Eq.Depth(i);
        scEqStruct(scCnt).Position = Eq.Position(i);
        scCnt = scCnt + 1;
    end
end
scEqTable = struct2table(scEqStruct);
%%
figure(1)
geoscatter(Eq.Latitude,Eq.Longitude,15.*Eq.Level,'.')
figure(2)
geobubble(scEqTable.Latitude,scEqTable.Longitude,15.*scEqTable.Level)
%% rose
[x,t] = meshgrid(0:0.1:1,-1:.03:30);
p = (pi/2)*exp(-t/8);
u = 1-(1-mod(3.6*t,2)).^4/2;
y = 2*(x.^2-x).^2.*sin(p);
r = u.*(x.*sin(p)+y.*cos(p));
figure('color','w'),view(104,41),axis image off
surface(r.*cos(t*pi),r.*sin(t*pi),...
    u.*(x.*cos(p)-y.*sin(p)),'EdgeColor','none','FaceColor','r')
light('style','local','pos',[1 -1 3]),lighting gouraud


%%
t = (0:.02:2)*pi;
r = 0:.02:1; %r = 0.3:.02:1; 
pcolor(cos(t)'*r,sin(t)'*r,t'*(r==r))
colormap(hsv(256)), shading interp, axis image off
%ezsurf('r*cos(t)','r*sin(t)','t',[0 1 0 2*pi])
%colormap(hsv(256)),shading interp,view(2), axis image off


%%
ts = 1e-3; % 采样周期
s = tf('s');
Gs = 1/(s^3+1)*exp(-ts*2*s);
Dgs = c2d(Gs,ts,'zoh') %以零阶保持器的方式进行离散化（Z变换）；
[num,den] = tfdata(Dgs,'v')% 'v'强制返回Vector而非Cell类型数据；
