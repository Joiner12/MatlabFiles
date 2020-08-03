%% add word cloud into a figure
%% cloud
clc;
pythonPath = 'D:\Python_M\Code\PythonDA';

dirpath = 'H:\MatlabFiles\Blocks\WallPaperHandle';
txt_file = fullfile(dirpath,'wenben.txt');
bg_cloud = fullfile(dirpath,'win10-wallpaper-bg.jpg');
tar_cloud = fullfile(dirpath,'wordcloud.jpg');
tar_pic = fullfile(dirpath,'2.jpg');
% gridPic = GridPicture('H:\MatlabFiles\Blocks\WallPaperHandle\result2.jpg',[1,2]);
% add script search path
if false
    ManagePythonPath(pythonPath,3);
%     def Gen_WordCloud(txt_file,bg_cloud,tar_cloud,tar_pic):
%     py.WcMaker.Gen_WordCloud(txt_file,bg_cloud,tar_cloud,tar_pic);
end
%% grid
tar_pic_grid = GridPicture(tar_pic,[2 2]);

%% fussion
source= tar_cloud;
target = tar_pic_grid;
result='cloud-grid-fuss.jpg';
I1 = imread(source);           % SOURCE IMAGE
I2 = imread(target);           % DESTINATION IMAGE
PIE_Gui(I1,I2,result,1,0);
%% cat
CatPicture(tar_pic_grid,result)
%% 
function Fussion_R(src,tar,des)
    I1 = imread(src);           % SOURCE IMAGE
    I2 = imread(tar);           % DESTINATION IMAGE
    PIE_Gui(I1,I2,des,1,0);
end