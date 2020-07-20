%% Ë«¶þ½×ÂË²¨Æ÷
% 
clc;clear;
close all;
disp('Ë«¶þ½×ÂË²¨Æ÷')
num=[0,0,1];
dec=[1,2,2];
%{
                 P0
    G(s) =  -------------
            s^2 + ¦Ø0/Q s + ¦Ø^2
%}
second_orderfilter = tf(num(3),dec);
tic
figure
for i=1:1:50
    num(3) = i;
    second_orderfilter = tf(num(3),dec);
    bode(second_orderfilter)
    grid on
    hold on 
end
hold off
toc