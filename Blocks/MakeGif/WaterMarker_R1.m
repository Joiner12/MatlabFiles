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
strText = 'û���';
pic_2 = insertShape(pic_1,'Line',line_points,'Color', {'white'},'LineWidth',3);
pic_2  = insertText(pic_2,[int32(sizePic(2)/2),int32(sizePic(1)/2)],strText,...
    'Font','Microsoft YaHei','FontSize',20,'BoxOpacity',0, ...
    'TextColor',[0.2 0.5 0.7]);
imshow(pic_2);


%%
clc;
video_file = 'C:\Users\10520\Desktop\fashou.mp4';
GifMake.CutFromVideo('hua.gif',video_file);
%%
tcf();
clc;
clear;
Lovinu = ["�Ұ���","��η�˺���ӵ��","�þ�����������",...
    "ֻΪ�ܿ�����","����һ����","������",...
    "�������µ�����","�������µĸ���","����ĳ�Ϧ"];
A = imread('fashou29-b.png');
B = insertText(A,[200 300],char(Lovinu(end-2)),'FontSize',100,...
    'Font','SimSun','TextColor',[189,32,32],...
    'AnchorPoint','LeftBottom',...
    'BoxColor',[0.94,0.92,0.92],'BoxOpacity',0.0);
imshow(B)
