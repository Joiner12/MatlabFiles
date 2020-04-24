function [dmodel2,initial_add_point,initial_add_value]=convex_eg1(error)
%P25算例
s=load('s.mat');
s=s.s;
ss=load('ss.mat');
ss=ss.ss;
ys=load('ys.mat');
ys=ys.ys;
yss=load('yss.mat');
yss=yss.yss;
mean_y = load('mean_y');
mean_y = mean_y.mean_y;

x_Ini=s;
y_Ini=ys;
varnum=size(s,2);
theta = ones(1,varnum)*2;
lob = ones(1,varnum)*1E-10;
upb = ones(1,varnum)*5;
method=4;
maxEII=zeros(150,1);
% [dmodel1,perf] = dacefit(x_Ini,y_Ini,@regpoly0, @corrgauss, theta, lob, upb,method);
[dmodel1,perf] = dacefit(x_Ini,y_Ini,@regpoly0, @corrgauss, theta, lob, upb);
num=1E5;
a=zeros(num,1);
c=zeros(num,1);
%----------------------
for i=1:150
    i
%________________________________________新的学习方程
for j=0:9
    [aa,cc]=predictor(ss(1E4*j+1:1E4*(j+1),:),dmodel1);
    a(1E4*j+1:1E4*(j+1))=aa;
    c(1E4*j+1:1E4*(j+1))=cc;
end
miug=a;
sigmag=c;
sigmag=sigmag.^0.5;
        Min_f = min(y_Ini);
        Ex1 = (Min_f - miug).*normcdf((Min_f - miug)./sigmag) + sigmag.*normpdf((Min_f - miug)./sigmag);
        Max_f = max(y_Ini);
        Ex2 = (miug - Max_f).*normcdf((miug - Max_f)./sigmag) + sigmag.*normpdf((miug - Max_f)./sigmag);
        [maxEI1,addindex1]=max(Ex1);
        [maxEI2,addindex2]=max(Ex2);
        if maxEI1>=maxEI2 
           maxEII(i)=maxEI1;
           addindex = addindex1;
        else
           maxEII(i)=maxEI2;
           addindex = addindex2;
        end
        maxEI = maxEII(i)
        x_Ini=[x_Ini;ss(addindex,:)];
        y_Ini=[y_Ini;yss(addindex)];
      
%         [dmodel1,perf]=dacefit(x_Ini,y_Ini,@regpoly0, @corrgauss, theta, lob, upb,method);
       [dmodel1,perf]=dacefit(x_Ini,y_Ini,@regpoly0, @corrgauss, theta, lob, upb);
%           (maxEI/mean_y)<error
        if   maxEI<error
            
            break
        end
   
end
initial_add_point = x_Ini;
initial_add_value = y_Ini;
dmodel2 = dmodel1;
end
