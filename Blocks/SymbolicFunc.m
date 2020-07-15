%% 
%{
    ·ûºÅº¯Êý.
%}
clc;
syms err tarh k bk;
% errOut = err/(1+k*(boundary - err)/boundary);(err <  boundary) 
snlf_1 = err/(1+k*(bk*tarh - err)/(bk*tarh));
dsnlf_1 = diff(snlf_1,err)
anlf_1 = matlabFunction(snlf_1)
adnlf_1 = matlabFunction(dsnlf_1)
gainf_1 = (1+k*(bk*tarh - err)/(bk*tarh))
againf_1 = matlabFunction(gainf_1)
%% 
try
    close('nlf')
catch
end
figure('name','nlf')
tarh_d = 0.3;
k_d = 13;
bk_d = 2;
x = 0:0.01:0.3*bk_d;
y = anlf_1(bk_d,x,k_d,tarh_d);
subplot(221)
plot(x,x,x,y)
subplot(222)
dy = adnlf_1(bk_d,x,k_d,tarh_d);
dy_1 = againf_1(bk_d,x,k_d,tarh_d);
plot(x,dy_1)

subplot(223)
plot(x,sqrt(x))
