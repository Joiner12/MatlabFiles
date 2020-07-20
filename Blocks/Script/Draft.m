%%  WGN-正态分布(Normal Distribution)
clc;clear;
Nd = @(x,delta,miu) exp(-(x-miu).^2/2/delta^2)/(sqrt(2*pi)*delta);
x = linspace(-100,100,1000);
y = Nd(x,20,0);
figure
plot(x,y)

%%
clc;
desktop = dir('C:\Users\10520\Desktop\sj');
for i = 1:1:length(desktop)
    if (contains(desktop(i).name,'NMOD.NET - ')) || (contains(desktop(i).name,'ePUBw.COM - '))
        fprintf('%s\n',desktop(i).name);
        filein = dir(fullfile(desktop(i).folder,desktop(i).name));
        
        % 文件夹
        if contains(desktop(i).name,'NMOD.NET - ')
            oldname = desktop(i).folder;
            newname = strrep(desktop(i).name,'NMOD.NET - ','')
            command = ['rename' 32 oldname 32 newname];
            status = dos(command);
        end
        if contains(desktop(i).name,'ePUBw.COM - ')
            oldname = desktop(i).folder;
            newname = strrep(desktop(i).name,'ePUBw.COM - ','');
            command = ['rename' 32 oldname 32 newname];
            status = dos(command);
        end
        
        % 文件
        for k = 1:1:length(filein)
            if contains(filein(k).name,'NMOD.NET - ')
                oldname = filein(k).name;
                newname = strrep(filein(k).name,'NMOD.NET - ','');
                command = ['rename' 32 oldname 32 newname];
                status = dos(command);
            end
            if contains(filein(k).name,'ePUBw.COM - ')
                oldname = filein(k).name
                newname = strrep(filein(k).name,'ePUBw.COM - ','')
                command = ['rename' 32 oldname 32 newname];
                status = dos(command);
            end
            
        end
        command = ['rename' 32 oldname 32 newname];
        status = dos(command);
    end
end


%% 
a = [];
cnt = 1;
b = 0:1:43;
for i = 0:1:43
    a(cnt) = sqrt(2017+i^2);
    cnt = cnt + 1;
end
%% square
close all;
clc;
t = linspace(0,5*pi,601)';
y = square(t);
y1 = sin(t);

% rectpulse
figure
subplot(321)
plot(t/pi,y)
hold on 
plot(t/pi,y1)
title('square')

subplot(322)
fs = 1e3;
tr = -1:1/fs:1;
y_rectpulse = rectpuls(tr,100/fs);
plot(tr,y_rectpulse)

subplot(323)
ttr = -1:1/fs:1;
y_tripuls = tripuls(ttr,200/fs);
plot(ttr,y_tripuls)

subplot(324)
T = 10*(1/50);
Fs = 1000;
dt = 1/Fs;
t = 0:dt:T-dt;
x = sawtooth(2*pi*50*t);

plot(t,x)
grid on