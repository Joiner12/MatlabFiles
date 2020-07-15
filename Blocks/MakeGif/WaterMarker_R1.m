%% water marker
clc;close all;
% obtain target picture
vFile = '20200625_132148.mp4';
if ~exist('pic_1.png','file') && false
    tarPic = 'pic_1.png';
    vObj = VideoReader(vFile);
    pic_1 = read(vObj,1);
    imwrite(pic_1,tarPic)
end

if ~exist('pic_1','var')
    pic_1 = imread('1.jpg');
end
sizePic = size(pic_1);
line_points = [183 297 100 250];
strText = 'Ã»ÏëµÄ';
pic_2 = insertShape(pic_1,'Line',line_points,'Color', {'white'},'LineWidth',3);
pic_2  = insertText(pic_2,[int32(sizePic(2)/2),int32(sizePic(1)/2)],strText,...
    'Font','Microsoft YaHei','FontSize',20,'BoxOpacity',0, ...
    'TextColor',[0.2 0.5 0.7]);
imshow(pic_2);


