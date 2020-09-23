%% ger ÊÇ¶Ì·¢
clc;
source= './Pics/netmusic-1.jpg';
target = './Pics/2-1.jpg';
result='./Pics/netfuss.jpg';
% 19.1
clc;
[A,map] = imread(source);
B = imread(target);
A = imresize(A,[size(B,1) size(B,2)]);
c = imadd(A,rgb2gray(B),'uint8');
tcf('hha')
figure('name','hha')
subplot(311)
imshow(A)
subplot(312)
imshow(B)
subplot(313)
imshow(ind2rgb(c))
return 
ColorReverse(source);