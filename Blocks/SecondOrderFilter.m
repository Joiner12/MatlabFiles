%% ˫�����˲���
% 
clc;clear;
close all;
disp('˫�����˲���')
num=[0,0,1];
dec=[1,2,2];
%{
                 P0
    G(s) =  -------------
            s^2 + ��0/Q s + ��^2
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