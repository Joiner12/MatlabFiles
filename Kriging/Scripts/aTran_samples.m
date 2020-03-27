clc
clear

Para1=[0.05,0.043,0.035,0.032,1,1000,2E11];
Para2=0.0045*[0.05,0.043,0.035,0.032,1,1000,2E11];

distribution={'norm','norm','norm','norm','norm','norm','norm'};
Nx=length(Para1);
Nt=100012;  

Dp = sobolset(Nx,'Skip',1e3,'Leap',1e2);

for i=1:Nx
    Xt(:,i)=icdf(distribution{i},Dp(1:Nt,i),Para1(i),Para2(i));
end
count=0;

[y]=g(Xt);
s = Xt(1:12,:);
ss = Xt(13:end,:);

ys = y(1:12,:);
yss = y(13:end,:);

mean_y = mean(y);

save s.mat s;
save ys.mat ys;
save ss.mat ss;
save yss.mat yss;
save mean_y.mat mean_y;
