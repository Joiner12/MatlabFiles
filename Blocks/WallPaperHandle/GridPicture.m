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
col_width = row_width;
% col_width = 5*screen(1)/screen(2);

[A,map] = imread(pic);

%% array
A_size = size(A);
% get anchor
if true && false
    frectangle = zeros((rows-1)*(cols-1),4);
    frectCount = 0;
    for j=1:1:cols-1
        for i=1:1:rows-1
            frectCount = frectCount + 1;
            %[x,y,w,h]
            frectangle(frectCount,:) = [i*A_size(1)/(rows),...
                j*(A_size(2)/cols),...
                A_size(2),...
                0];
        end
    end
end

%% cat 
if true
    GridR1 = [0,A_size(1)/2 - 5,A_size(2),10];
    % GridR2 = [0,2*A_size(1)/3 - 5,A_size(2),10];
    GridR3 = [A_size(2)/4 - 5,0,5,A_size(1)];
    GridR4 = [2*A_size(2)/4 - 5,0,10,A_size(1)];
    GridR5 = [3*A_size(2)/4 - 5,0,5,A_size(1)];
    % GridR = [GridR1;GridR3;GridR4;GridR5];
    GridR = [GridR1;GridR4];
end

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
fprintf('Grid picture finished\n');
% imtool(B)
end