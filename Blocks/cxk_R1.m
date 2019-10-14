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
im = 'C:\Users\10520\Desktop\cxk.jpg';
A = imread(im);
B = zeros(178,284);
C = rgb2gray(A);
B = uint8(B);
a_size = size(C);
for i = 1:1:a_size(1)
    for j = 1:1:size(2)
        if C(i,j) < 125
            B(i,j) = 125*0.5;
        else
            B(i,j) = C(i,j);
        end
    end
end
imshow(B)
toc(t1)