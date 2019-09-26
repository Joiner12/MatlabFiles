clc;
clear;
if ~isequal('D:\Codes\MatlabFiles\Blocks',pwd)
    cd('D:\Codes\MatlabFiles\Blocks')
    fprintf('Reload path: %s\n',pwd);
end
%%
%{
    1.读取*.mp3信息;
    2.绘制spectrogram
%}
clc;
file = 'C:\Users\10520\Desktop\city of blue.mp3';
[bluesky,fs] = audioread(file);
single_bluesky = bluesky(:,1);

%%
single_bluesky = single_bluesky(1000:10:end-10000);
spectrogram(single_bluesky,100,80,100,fs/100,'yaxis')
view(-77,72)
shading interp
colormap bone
colorbar off
axis off
title('天空之城')
