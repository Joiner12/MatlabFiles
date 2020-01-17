%% path
clc;clear;
if ~isequal(pwd,'H:\MatlabFiles\ADRC\Scripts')
    cd H:\MatlabFiles\ADRC\Scripts
end
fprintf('Load path...\n%s\n',pwd);

%% capcity edge 
%{
    电容边缘效应问题分析
%}
clc;
% load base datas 
try
    load('H:\MatlabFiles\DetectEdge\标定数据边缘中间\ratingdata.mat');
    fprintf('load data succeed.\n')
catch
    fprintf('load data from failed.\n');
end

%% overview figure
try
    close('capsearch')
catch
end
figure('name','capsearch')
subplot(211)
plot(NormalSensor(:,1),NormalSensor(:,2),'linewidth',2)
hold on
plot(InLight(:,1),InLight(:,2),'linewidth',2)
hold on 
plot(HalfOutSensor(:,1),HalfOutSensor(:,2),'linewidth',2)
hold on 
plot(HalfOutLight(:,1),HalfOutLight(:,2),'linewidth',2)
grid minor
% axis([min(HalfOutLight(:,1)) max(HalfOutLight(:,1)) -100 1700])
legend('normal','in light','half sensor','half light')

subplot(212)
plot(NormalSensor(:,1)./HalfOutLight(:,1))


%% from 10mm to 0.1mm analysis gap:0.1mm
clc;
ML = 10:10:1000;
[x1,y1] =  GapLen(NormalSensor(:,2),NormalSensor(:,1));
[x2,y2] =  GapLen(HalfOutLight(:,2),HalfOutLight(:,1));
[x3,y3] =  GapLen(HalfOutSensor(:,2),HalfOutSensor(:,1));
[x4,y4] =  GapLen(InLight(:,2),InLight(:,1));
figure
plot(x1,1e6./y1','linewidth',2)
hold on 
plot(x2,1e6./y2','linewidth',2)
hold on
plot(x3,1e6./y3','linewidth',2)
hold on
plot(x4,1e6./y4','linewidth',2)
legend('normal','halfligth','halfsensor','inlight')
%% 通过电容查找位置
%{
    二分查表
%}
function height = FreFindHei(fre,FreBaseData,HeiBaseData)
    dataLen = length(FreBaseData);
    maxfre = max(FreBaseData);
    minfre = min(FreBaseData);
    maxheight = max(HeiBaseData);
    flag = 0;
    if(dataLen > 1)
         for i=1:1:dataLen - 1
            % 二分位置
            if fre > maxfre
                height = maxheight;
                flag = 1;
            elseif fre >= FreBaseData(i) && fre <= FreBaseData(i+1)
               height = HeiBaseData(i);
            elseif fre < minfre
                height = 0;
            end
         end
    else
        height = 9999;
        error('check your basedata')
    end
    if flag == 1
        
    end
end

%% from 10mm to 0.1mm analysis gap:0.1mm
function [x,y] =  GapLen(height,cap)
    if length(height) ~= length(cap)
        x = 0;y = 0;
        error('length is not equal')
        return ;
    end
    x = linspace(10,1000,100);
    y = zeros(100,1);
    index_src = 1;
    for i=1:1:length(x)
        curheight = x(i);
        if length(find(height == curheight)) == 1
            index_src = find(height == curheight);
        end
        y(i) = cap(index_src);
    end
end


