%% add word cloud into a figure
clc;
try
    if isequal(files,0)
        [files,path] = uigetfile(strcat(pwd(),'\','*.png;*.jpg;*.jpeg'),...
            'MultiSelect','off');
        if isequal(files,0)
            fprintf('select cancle\n');
            return;
        end
    end
catch
    
end

[Pic_A,Pic_map] = imread(fullfile(path,files));
Pic_B = rgb2gray(Pic_A);
tcf('ssf')
figure('name','ssf')
subplot(211)
imshow(Pic_A)
subplot(212)
imshow(212)
imshow(Pic_B)


