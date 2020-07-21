%% add word cloud into a figure
clc;

[files,path] = uigetfile(strcat(pwd(),'\','*.png;*.jpg;*.jpeg'),...
    'MultiSelect','off');
if isequal(files,0)
    fprintf('select cancle\n');
    return;
end

[Pic_A,Pic_map] = imread(fullfile(path,files));
Pic_B = rgb2gray(Pic_A);

%%
clc;
[Pic_C,Pic_D] = C_Wph.deltaFigure(Pic_B);
tcf('ssf')
figure('name','ssf')
subplot(221)
imshow(Pic_A)
subplot(222)
imshow(Pic_B)
subplot(223)
imshow(Pic_C)
subplot(224)
imshow(Pic_D)
