%
fprintf('load path...\n');
if ~isequal('D:\Codes\MatlabFiles\Blocks',pwd)
    cd('D:\Codes\MatlabFiles\Blocks');
end
fprintf('%s\n',pwd)
%%
clc;
t1 = tic;
fprintf('cxks...\n');
% [file,path] = uigetfile({'*.png'});
im = 'C:\Users\10520\Desktop\cxk.png';
[A,map] = imread(im);
C = rgb2gray(A);
imshow(C)
a_size = size(C);
for i = 1:1:a_size(1)
    for j = 1:1:a_size(2)
        if C(i,j) < 200
            fprintf('%d',1);
        else
            fprintf('%d',0);
        end
    end
    fprintf('\n')
end
toc(t1)