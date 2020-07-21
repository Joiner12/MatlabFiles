%% grid pictures
function gridPic = GridPicture(pic,grids)
%  grid pictures
screen = [1080 1920];
gridPic = '';
if ~isfile(pic)
    error('no such file ');
end
gridTemp = grids;
gridTemp(gridTemp < 1) = 1;
if length(gridTemp) ~= 2
    error('gridTemp set fault');
end
rows = gridTemp(1);
cols = gridTemp(2);
row_width = 10;
col_width = row_width*screen(1)/screen(2);

% get ancle

for i=1:1:rows
    for j=1:1:cols
        
    end
end

[A,map] = imread(pic);

A_size = size(A);
GridR1 = [0,A_size(1)/2 - row_width/2,A_size(2),row_width];
GridR2 = [0,2*A_size(1)/3 - 5,A_size(2),10];
if true
    GridR3 = [A_size(2)/2 - row_width/2,0,row_width,A_size(1)];
else
    GridR3 = [A_size(2)/2 - col_width/2,0,col_width,A_size(1)];
end

GridR4 = [2*A_size(2)/4 - 5,0,5,A_size(1)];
GridR5 = [3*A_size(2)/4 - 5,0,5,A_size(1)];
GridR = [GridR1;GridR3];
GrColor = 'white';
B = insertShape(A,'FilledRectangle',GridR,'Color',{'white'});
imot = '';
try
    [dirname,name,ext] = fileparts(pic);
    imot = strcat(fullfile(dirname,name),'-grid',ext);
    imwrite(B,imot);
    fprintf('origin picture:%s ¡ú grid picture:%s\n',pic,imot);
    gridPic = imot;
catch
    error('gird picture failed');
end
% imtool(B)
end