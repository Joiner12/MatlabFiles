%% path
clc;clear;
if ~strcmp(pwd,'H:\MatlabFiles\ADRC\Scripts')
    cd('H:\MatlabFiles\ADRC\Scripts');
end
fprintf('Road path...%s\t\n%s\n',pwd,'ADRC');
clear ans

%%
%{
    write data to *.txt file
%}
clc;
% 生成各种原始信号
% step + sin(1hz - 15hz)
clc;clear;
tdtest = zeros(2,5000);
basefre = 1;

Step_1 = zeros(1,1000);
One_1 = ones(1,200);
Zero_1 = zeros(1,200);
Stair_1 = [Zero_1,7500.*One_1,5000.*One_1,2500.*One_1,5000.*One_1];

t = linspace(0,1,1000);
Sin_1 = 2500*sin(2*basefre*pi.*t) + 5000;
Sin_2 = 2500*sin(2*5*basefre*pi.*t) + 5000;
Sin_3 = 2500*sin(2*10*basefre*pi.*t) + 5000;
Sin_4 = 2500*sin(2*20*basefre*pi.*t) + 5000;
Signal = [Stair_1,Sin_1,Sin_2,Sin_3,Sin_4];
close all
figure(1)
subplot(221)
plot(t,Sin_1)
hold on
plot(t,Sin_2)
hold on
plot(t,Sin_3)
hold on
plot(t,Sin_4)
grid minor
subplot(222)
plot(linspace(0,5,5000),Signal)
grid minor
subplot(223)
plot(Stair_1)
grid minor
subplot(224)
Signal_wgn = zeros(size(Signal));
if true
    Signal_wgn = wgn(1,5000,40)+ Signal;
end
plot(Signal)
hold on
plot(Signal_wgn)
set(get(gca, 'Legend'), 'String',["signal","wgn"]);

%%
datafile = 'H:\MatlabFiles\ADRC\srcdata.txt';
if true
    dataIn = [linspace(1,5000,5000);Signal_wgn];
else
    dataIn = [linspace(1,5000,5000);Signal];
end
fileId = fopen(datafile,'w','n','gbk');
if ~isequal(fileId,-1)
    if true
        for i = 1:1:length(dataIn(1,:))
            fprintf(fileId,'%i,%i\n',dataIn(1,i),int32(dataIn(2,i)));
        end
    else
        fwrite(fileId,dataIn,'uint');
    end
    
    fclose(fileId);
end
winopen(datafile)


%%
%{
    校验td
    校验结果：
    代码验证完成 2019-10-10
%}
clc;
fprintf('Verify Td...\n');
datafileSrc = 'H:\MatlabFiles\ADRC\srcdata.txt';
datafileOut = 'H:\MatlabFiles\ADRC\outdata.txt';
sample = 1e-3; % 采样周期
dataSrc = zeros(0);  % [timecnt;height];
dataOut = zeros(0);  % [trackheight;diffheight;deltaheight];

dataSrc = load(datafileSrc);
dataSrc = dataSrc';
dataOut = load(datafileOut);
dataOut = dataOut';

%%
figure
subplot(211)
plot(dataSrc(1,:)*sample,dataSrc(2,:))
hold on
plot(dataOut(1,:)*sample,dataOut(2,:))
% hold on
% plot(dataOut(1,:)*sample,dataOut(3,:)*1000)

subplot(212)
plot(dataOut(1,:)*sample,dataOut(3,:))
% hold on
% plot(dataOut(1,:)*sample,dataOut(4,:)/1000)
legend('微分','差分')