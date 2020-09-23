%% replace background
%{
    reference:
    https://blog.csdn.net/sinat_31824577/article/details/56281811
%}
clc;
clear;
cprintf('comment','replace background\n');
[files,path] = uigetfile('pictemp\*.png;*.jpg','MultiSelect','on');
if isempty(files)
    return;
end
%% 清空缓存文件夹
if isfolder('tar_temp')
    rmdir tar_temp s;
end
mkdir('tar_temp');
for file_index = 1:1:length(files)
    ReplaceBackgroundColor(fullfile(path,files{file_index}),'tar_temp');
end
cprintf('comment','transfer finished..\n');
tcf();
%% make gif
cprintf('comment','make gif\n');
GifMake.ConpositeGif('naaa','tar_temp');
wp();

%% replace background
function ReplaceBackgroundColor(file,varargin)
img = imread(file);
[height,width,a] = size(img);
% black:[36 36 36]
matrix = (img(:,:,1)< 30)|(img(:,:,2)< 30)|(img(:,:,2) < 30); % 选择黑色的像素点
%matrix(0.2*height:height,0.25*width:0.75*width) = 0;  % 区域保持不变
se = strel('disk',3);
matrix = imclose(matrix,se);  % 关操作平滑边缘
imshow(matrix)
[a,b] = find(matrix == 1);
white = [255,255,255];
color = white;
for i = 1:size(a)
    img(a(i),b(i),1) = color(1);
    img(a(i),b(i),2) = color(2);
    img(a(i),b(i),3) = color(3);
end
%平滑处理
g1=medfilt2(img(:,:,1));%%红
g2=medfilt2(img(:,:,2));%%绿
g3=medfilt2(img(:,:,3));%%蓝
img1(:,:,1) = g1;
img1(:,:,2) = g2;
img1(:,:,3) = g3;
imshow(img1);
% save target
if length(varargin) < 1
    imwrite(img1,'Pics/huashou-b.png');
else
    [~,filename,ext] = fileparts(file);
    imwrite(img1,strcat(varargin{1},'\',filename,'-b',ext));
end
end
