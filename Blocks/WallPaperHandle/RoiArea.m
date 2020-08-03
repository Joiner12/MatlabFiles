%% PS-1 remove watermaker
clc;
tcf('Aoto');
global Ffig fp plt_1 plt_2 ButtonSelectFile ButtonSelectArea RoiC RoiR SRC;
Ffig = figure('name','Aoto','Position',[40 100 500*1920/1080 500]);
fp = uipanel(Ffig,'Position',[0.01 0.75 0.4 0.2]);
ButtonSelectFile = uicontrol(fp,...
    'Style','pushbutton',...
    'String','InsertFile',...
    'Position',[10 10 50 20]);
ButtonSelectArea = uicontrol(fp,...
    'Style','pushbutton',...
    'String','SelectArea',...
    'Position',[10 40 50 20]);

plt_1 = subplot('Position',[0.05 0.1 0.4 0.5]);
plt_2 = subplot('Position',[0.55 0.1 0.4 0.5]);

% callback function registor
ButtonSelectFile.Callback = @GetImageFile;
ButtonSelectArea.Callback = @PIE_SelectArea;

% init value
RoiC = zeros(0);
RoiR = zeros(0);
SRC = zeros(0);


%% get image file
function GetImageFile(~,~)
global imgPath plt_1;
[file,path] = uigetfile('./*.*','MultiSelect','off');
if isempty(file)
    imgPath = '';
else
    imgPath = fullfile(path,file);
    A = imread(imgPath);
    imshow(A,'Parent',plt_1)
end
fprintf('Image file:%s\n',imgPath);
end

%% select interested area in a figure
function  PIE_SelectArea(~,~,~,~,~)
global imgPath plt_1 plt_2 RoiR RoiC SRC;
try
    I1 = imread(imgPath);
catch
    return;
end
% this returns a binary image with white (1) in the mask
% [BW, xi, yi] = roipoly(I1,'Parent',plt_1);
% plt_1.axes = 'equal';
[BW, xi, yi] = roipoly(I1);
% extract mask (crop image)
[r,c] = find(BW == 1);                      % find the max values
maxH = max(r) - min(r);                     % extract the height
maxW = max(c) - min(c);                     % extract the width
SRC = imcrop(I1,[min(c) min(r) maxW maxH]);  % crop the image in the RIO
if false
    % crop mask - make the mask RGB (3 layers)
    Mc = zeros(size(SRC));                       % make a copy of Ic
    Mc(:,:,1) = imcrop(BW,[min(c) min(r) maxW maxH]);
    Mc(:,:,2) = imcrop(BW,[min(c) min(r) maxW maxH]);
    Mc(:,:,3) = imcrop(BW,[min(c) min(r) maxW maxH]);
end
RoiR = r;
RoiC = c;
imwrite(SRC,'H:\MatlabFiles\Blocks\WallPaperHandle\aotoChild.jpg');
imshow(SRC,'Parent',plt_1);
end

