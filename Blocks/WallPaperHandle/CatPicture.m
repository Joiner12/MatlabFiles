%% Í¼Æ¬Æ´½Ó
function catPicFile = CatPicture(pic_1,pic_2)
if ~isfile(pic_1) || ~isfile(pic_2)
    catPicFile = '';
    error('not file ')
end

[A1,map] = imread(pic_1);
[A2,map] = imread(pic_2);


size_a = size(A1);
size_b = size(A2);
if ~isequal(sum(size_a == size_b ),length(size_a))
    return
end
B = zeros(0);
B = [A1,A2];
[dirname,name_1,ext] = fileparts(pic_1);
[~,name_2,~] = fileparts(pic_2);
imwrite(B,fullfile(dirname,strcat(name_1,'cat',name_2,ext)));
try
    cprintf('Comments','grid on %s: ¡ú %s\n',pic_1,pic_2);
catch
    fprintf('grid on %s: ¡ú %s\n',pic_1,pic_2);
end
end