%% set parameter of kp eso through modifying bandwidth of eso 
%{
    reference:
    [1] I:\RecentDocs\Scaling and Bandwidth-Parameterization Based Controller Tunning.pdf
%}
clc;
fre = 35;   % hz
b0 = 400;
wo = 6.28*fre; % rad/s
beta0 = 2*wo;
beta1 = wo*wo;
gain1 = 5;
wc = gain1*wo;
kp = wc*wc/b0;
fprintf('wc:%.0f rad/s,wo:%.0f rad/s,kp:%.0f,eso:%0.0f,%0.0f ,b0:%.0f\n',wc,wo,kp,beta0,beta1,b0);

