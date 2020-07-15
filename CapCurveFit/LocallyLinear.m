%% locally linear
clc;
if ~exist('demarC','var') && ~exist('demarH','var')
    demarData = DrawCF(1);
    demarH = demarData(:,2);
    demarC = demarData(:,1);
    demarC = demarC - min(demarC);
    demarH = demarH./100;
end

splitPoints = 16;
dataLen = length(demarH);
splitH = demarH(1:int32(dataLen/splitPoints):end);
splitC = demarC(1:int32(dataLen/splitPoints):end);

% nonlinear degree
nlC = diff(demarC);
nlH = diff(demarH);

tcf('sfa')
figure('name','sfa')
subplot(221)
plot(demarC,demarH)
hold on
scatter(splitC,splitH,'*')
subplot(222)
plot(splitC,splitH)

subplot(223)
plot(demarH(1-length(nlH) + length(demarH):end),nlC./nlH)
title('非线性度')


%% curve fitting 
clc;
x1 = demarC(10:20);
y1 = demarH(10:20);
[m,b,func_1] = CurveFitting.OrdinaryLS(x1,y1)
cfx = x1;
cfy = func_1(m,b,cfx);

tcf('duixiang')
figure('name','duixiang')
plot(x1,y1)
hold on 
plot(cfx,cfy)
legend('ra','as')