%% net music
filepath = 'D:\Codes\MatlabFiles\Blocks';
cd(filepath)
%%
clc;
clear;
file_1 = 'C:\Users\10520\Desktop\°¢É£ - ÎÂÈáµÄ´È±¯.flac';
[y,Fs] = audioread(file_1);
a=linspace(1,10000,10000);
sound(a,1000)