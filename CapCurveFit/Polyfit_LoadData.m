%% load data 
%{
    C:\Users\Whtest\Desktop\capComp\bodor-20200708\电容采集\bodor-0712\第三次\parse
    data_0=[电容频率 电容高度]
%}
clc;
refrigeration_0_mat = zeros(length(refrigeration_0),2);
for k =1:length(refrigeration_0)
    temp = ParseLog(refrigeration_0{k});
    refrigeration_0_mat(k,:) = temp(1:2);
end

refrigeration_2_mat = zeros(length(refrigeration_2),2);
for k =1:length(refrigeration_2)
    temp = ParseLog(refrigeration_2{k});
    refrigeration_2_mat(k,:) = temp(1:2);
end

refrigeration_4_mat = zeros(length(refrigeration_4),2);
for k =1:length(refrigeration_4)
    temp = ParseLog(refrigeration_4{k});
    refrigeration_4_mat(k,:) = temp(1:2);
end

refrigeration_6_mat = zeros(length(refrigeration_6),2);
for k =1:length(refrigeration_6)
    temp = ParseLog(refrigeration_6{k});
    refrigeration_6_mat(k,:) = temp(1:2);
end

refrigeration_10_mat = zeros(length(refrigeration_10),2);
for k =1:length(refrigeration_10)
    temp = ParseLog(refrigeration_10{k});
    refrigeration_10_mat(k,:) = temp(1:2);
end

refrigeration_12_mat = zeros(length(refrigeration_12),2);
for k =1:length(refrigeration_12)
    temp = ParseLog(refrigeration_12{k});
    refrigeration_12_mat(k,:) = temp(1:2);
end

clearvars -except refrigeration_12 refrigeration_12_mat ...
    refrigeration_10 refrigeration_10_mat ...
    refrigeration_6 refrigeration_6_mat ...
    refrigeration_4 refrigeration_4_mat ...
    refrigeration_2 refrigeration_2_mat ...
    refrigeration_0 refrigeration_0_mat ...
    
%%
refrigeration_0_mat_height = refrigeration_0_mat(:,1);
polyHeight = refrigeration_0_mat_height(refrigeration_0_mat_height < 400);
refrigeration_0_mat_cap = refrigeration_0_mat(:,2);
polyCap = refrigeration_0_mat_cap(refrigeration_0_mat_height < 400);
polyCap = polyCap - min(polyCap);
polyCap = polyCap./10;
%% 
tcf('fsc')
demarData = DrawCF('参数');
demarH = demarData(:,2);
demarC = demarData(:,1);
figure('name','fsc')
plot(demarC,demarH)
%% local linear
clc;

polyH = demarH(demarH < 550 & demarH > 500);
polyC = demarC(demarH < 550 & demarH > 500);
polyC = polyC - min(demarC);
polyC = polyC./100;