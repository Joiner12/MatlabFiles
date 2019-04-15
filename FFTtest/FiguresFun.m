%% Load path 
clc
cd D:\Coders\MatlabScrips\FFTtest
fprintf('Load path....\n%s \n',pwd)
%% 
%{
    Handle Origin Figures
%}
clc
disp('Handle picture...')
FileName02 = 'pg.jpg';
a = [];
A = imread( FileName02);

% mesh(A(:,:,1),A(:,:,2),A(:,:,3))

%% 
%{
    ...
    Imread & Imwrite
    ...
%}
clc
close all
if isempty(A)
    disp('empty array...')
    return
else
    B = A;
    C = zeros(0);D=zeros(0);E=zeros(0);
    disp('Not null size begin to operate....')
    dims = zeros(0);
    dims = size(A);
    for i = 1:1:dims(1)
        for j = 1:1:dims(2)
            for k = 1:1:dims(3)
                temp = B(i,j,k);
                B(i,j,k) = mod(185,temp);
                C(i,j,k) = mod(128,temp);
                D(i,j,k) = mod(64,temp);
                E(i,j,k) = mod(32,temp);
            end
        end
    end
    clear i j k temp 
    disp('finished')
end
%% 
%{
...
show images
...
%}
clc
ypig1 = imread('pig.gif',3);
ypig2 = imread('pig.gif',4);
fprintf('showing picture....\n')
figure
subplot(5,1,1)
imwrite(B,'pgd.jpg')
imshow('pgd.jpg')
subplot(5,1,2)
imwrite(C,'pgb.jpg')
imshow('pgb.jpg')
subplot(5,1,3)
imwrite(D,'pgc.jpg')
imshow('pgc.jpg')
subplot(5,1,4)
imwrite(E,'pga.jpg')
imshow('pga.jpg')
subplot(5,1,5)
imwrite(A,'pge.jpg')
imshow('pge.jpg')

% Generate *.gif
close all
%���·��+������ļ���.gif
disp('Generate pig.gif')
FileName01 = 'D:\Coders\MatlabScrips\FFTtest\pig.gif';
FilePath = 'D:\Coders\MatlabScrips\FFTtest\pg';
% filename='D:\\matlab_program\\Mycode\\fish1.gif';        
cnt = 0;
for i=97:101  
     %ͼƬ����λ�ú����ͣ�ע�������ͼƬ���Ͳ�����bmp��ʽ
    %{
        [97  98  99  100  101]
        [101 100 99  98   97 ]
    %}
    str = strcat(FilePath,char(i),'.jpg');
    img = imread(str);     %��ȡͼ��
    figure(i)
    imshow(img)
    set(gcf,'color','w');  %���ñ���Ϊ��ɫ
    set(gca,'units','pixels','Visible','off');
    frame = getframe(gcf); 
     %��ӰƬ����ת��Ϊ��ַͼ��,��Ϊͼ�������index����ͼ��
    im = frame2im(frame);    
    imshow(im);
    [I,map] = rgb2ind(im,20); %�����ɫͼ��ת��Ϊ����ͼ��
    if i==97
         %Loopcountֻ����i==1��ʱ�������
        imwrite(I,map,FileName01,'gif','Loopcount',inf,'DelayTime',0.5);    
    else
        %DelayTime:֡��֮֡���ʱ����
        imwrite(I,map,FileName01,'gif','WriteMode',...
            'append','DelayTime',0.8);
    end
end
close all
% imshow(ypig1,[])
% imshow(ypig2,[])

%% 
%{
    handle *.gif
%}
