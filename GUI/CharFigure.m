%% 
clc;
disp('Éú³É×Ö·ûÍ¼Æ¬')
PurposePath = 'D:\Coders\MatlabScrips\GUI';
if ~strcmp(PurposePath,pwd)
    cd D:\Coders\MatlabScrips\GUI
end
fprintf('load path\t>>>>\t%s\n',pwd)
clear ans

clear;clc;close all;
[file,path] = uigetfile({'*.jpg';'*.png'},'File Selector');
if isequal(file,0)
   disp('User selected Cancel');
   return
else
   disp(['User selected ', fullfile(path,file)]);
end
%% 
clc;close all;
Imdata = imread( fullfile(path,file));
if ~isempty(Imdata)
%     imshow(Imdata)
    figure
    subplot(2,1,1)
    title('RGB Image')
    imagesc(Imdata)
    axis equal
else
    disp('Empty image data')
    return;
end

% Get gray data
%{
R = double(Imdata(:,:,1));
G = double(Imdata(:,:,2));
B = double(Imdata(:,:,3));
ImGray = (R*299 + G*587 + B*114)/1000;
%}
ImGray = rgb2gray(Imdata);
subplot(2,1,2)
title('Gray Image')
imagesc(ImGray)
axis equal

%Gray to character
ImGray = ImGray(1:2:end,1:2:end);
[m,n] = size(ImGray);
for i = 1:1:m
    for j = 1:1:n
        switch fix(ImGray(i,j)./25)
            case 10
                ImGray(i,j) = '.';
            case 9
                ImGray(i,j) = '£¡';
            case 8
                ImGray(i,j) = 'u';
            case 7
                ImGray(i,j) = 'o';  
            case 6
                ImGray(i,j) = 'a'; 
            case 5
                ImGray(i,j) = '*'; 
            case 4
                ImGray(i,j) = 'p'; 
            case 3
                ImGray(i,j) = 'g'; 
            case 2
                ImGray(i,j) = 'm';      
            case 1
                ImGray(i,j) = '&';       
            case 0
                ImGray(i,j) = '$';                 
        end
    end
end

% Out to txt
ImGray = char(ImGray);
txtfile = [path,'OutChar.txt'];
dlmwrite(txtfile,ImGray,'delimiter',' ','newline','pc')
fprintf('>>>  Char finished...\n')

