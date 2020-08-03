%% ÑÕÉ«·­×ª
function ColorReverse(img)
    if ~isfile(img)
        return 
    end

    [A,map] = imread(img);
    A1 = rgb2ind(A,2^8);
    A2 = rgb2gray(A);
    A3 = 0.5.*(A1 + A2);
    A4 = imcomplement(A);
%     A4 = ones(size(A1));
    tcf('iss')
    figure('name','iss');
    subplot(221)
    imshow(A1)
    subplot(222)
    imshow(A2)
    subplot(223)
    imshow(A3)
    subplot(224)
    imshow(A4)
    a = 1;
end