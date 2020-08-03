%% ger
text = '';
source= 'H:\MatlabFiles\Blocks\WallPaperHandle\Pics\netmusic-3.jpg';
target = 'H:\MatlabFiles\Blocks\WallPaperHandle\Pics\2-1.jpg';
result='H:\MatlabFiles\Blocks\WallPaperHandle\Pics\netfuss.jpg';
% I1 = imread(source);           % SOURCE IMAGE
% I2 = imread(target);           % DESTINATION IMAGE
% PIE_Gui(I1,I2,result,1,0);

%% 
clc;
A = imread(source);
B = imread(target);
% B = B(1:size(A,1),1:size(A,2),:);
c = imadd(A,B,'uint8');
tcf('hha')
figure('name','hha')
% imshow(rgb2gray(A))
imshow(c)
return 
ColorReverse(source);