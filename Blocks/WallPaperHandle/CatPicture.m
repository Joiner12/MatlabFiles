%% Í¼Æ¬Æ´½Ó
function catPicFile = CatPicture(pic)
    if ~isfile(pic)
        catPicFile = '';
        error('not file ')
    end
    
    [A,map] = imread(pic);
    B = zeros(0);
    size_a = size(A);
    B = [A,A];
    [dirname,name,ext] = fileparts(pic);
    imwrite(B,fullfile(dirname,strcat(name,'-cat',ext)));
end