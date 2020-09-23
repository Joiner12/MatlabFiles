%% General Use is not enough
classdef GifMake
    methods (Static)
        % from gif to gif
        function  CutFromGif(filename_gif)
            fprintf('handle gif files\n');
            %                 filename = '1.gif';
            filename =  filename_gif;
            [gifIn] = imread(filename);
            size_gif = size(gifIn);
            pics = size_gif(end);
            new_gif = strcat('Gif',char(datetime('now','format','HHmmSS')),'.gif');
            gifDelay = 0.01;
            for vframe_i = 1:1:pics
                [A,map] = imread(filename,'Index',vframe_i);
                % curFrame = ind2rgb(A,map);
                % image(curFrame,'Parent',axes_frame);
                % gifFrame = getframe(gca);
                if isequal(vframe_i,1)
                    imwrite(A,map,new_gif,'LoopCount',inf,'DelayTime',gifDelay);
                else
                    imwrite(A,map,new_gif,'WriteMode','append','DelayTime',gifDelay);
                end
                % imshow(curFrame)
            end
            fprintf('Make gif finished,%s\n',new_gif);
        end
    end
    
    % from video to gif
    methods (Static)
        function HanldeStatu = CutFromVideo(gifname)
            HanldeStatu = false;
            %% load video
            close all;
            if false
                [file,path] = uigetfile('C:\Users\10520\Desktop\*.mp4;*.avi}');
            else
                file = 'Pics\oriv.mp4';
                path = pwd;
            end
            fprintf('create video obj from %s\n',fullfile(path,file))
            
            
            %% check frames
            if true && false
                implay(fullfile(path,file));
            end
            
            if ~iscell(file)
                vobj = VideoReader(fullfile(path,file));
            end
            vobj.hasFrame()
            hasFrame(vobj)
            %vobj_f = read(vobj,[137,197]);
            
            %% transfer video frame to figure frame
            video2pic = 1;
            im = cell(0);
            switch video2pic
                case 1
                    pic_cnt = 1;
                    while hasFrame(vobj) && pic_cnt < 1e4
                        curFrame = readFrame(vobj);
                        pic_file = strcat('pictemp\',num2str(pic_cnt),'.jpg');
                        rect = [91,330,260,260];
                        curFrame = imcrop(curFrame,rect);
                        imwrite(curFrame,pic_file);
                        im{pic_cnt} = curFrame;
                        pic_cnt = pic_cnt + 1;
                    end
                otherwise
                    fprintf('nothing to do\n');
            end
            return
            %% wirte to gif file
            if contains(gifname,'.gif')
                gif_file = gifname;
            else
                gif_file = strcat(char(datetime('now','format','HHmmSS')),'.gif');
            end
            gap = 50;
            for j = 1:1:length(im)
                if j==1
                    [A,map] = rgb2ind(im{j},256);
                    imwrite(A,map,gif_file,'LoopCount',...
                        inf,'DelayTime',gap*0.001);
                elseif j < length(im) - 1
                    [A,map] = rgb2ind(im{j},256);
                    imwrite(A,map,gif_file,'WriteMode',...
                        'append','DelayTime',gap*0.001);
                else
                    [A,map] = rgb2ind(im{j},256);
                    imwrite(A,map,gif_file,'WriteMode',...
                        'append');
                end
            end
            fprintf('from video:%s to gif:%s finished\n',file,gif_file);
            %             imshow(gif_file);
            %             saveflag = input(strcat('delete gif_file ?'));
            %             if
            %                 delete(gif_file);
            %             end
        end
    end
    
    %% scale figure
    methods (Static)
        % Bilinear Function
        function [ output_img ] = scale( input_img, Size )
            % Using bilinear algorithm to change the SIZE of input_img.
            dstM = Size(1);
            dstN = Size(2);
            [srcM ,srcN]=size(input_img);
            output_img = zeros(dstM, dstN);
            for i = 1:dstM - 1
                for j = 1:dstN - 1
                    src_i = i * (srcM / dstM);
                    src_j = j * (srcN / dstN);
                    int_i = fix(src_i);
                    int_j = fix(src_j);
                    u = src_i - int_i;
                    v = src_j - int_j;
                    if int_i == 0
                        int_i = int_i + 1;
                    end
                    if int_j == 0
                        int_j = int_j + 1;
                    end
                    output_img(i,j)=(1-u)*(1-v)*input_img(int_i,int_j)+...
                        (1-u)*v*input_img(int_i,int_j+1)+...
                        u*(1-v)*input_img(int_i+1,int_j)+...
                        u*v*input_img(int_i+1,int_j+1);
                end
            end
            output_img = uint8(output_img);
            %             figure,imshow(input_img)
            %             axis on
            %             figure,imshow(output_img)
            %             axis on
        end
    end
    
    
    %% grid pictures
    methods (Static)
        function GridPictue(pic)
            % [filepath,name,ext] = fileparts(pic);
            [A,map] = imread(pic);
            imshow(A)
        end
    end
    
    methods (Static)
        function ConpositeGif(gifname,varnargin)
            if varnargin > 0
                [files,path] = uigetfile('*.png;*.jpg','MultiSelect','on');
            else
                [files,path] = uigetfile('C:\Users\10520\Desktop\huashou\*.png;*.jpg',...
                    'MultiSelect','on');
            end
            if isempty(files)
                cprintf('comment','no files selected\n');
                return;
            end
            %%
            imgs = cell(0);
            %             files_path = strings(0);
            for i=1:1:length(files)
                A = imread(fullfile(path,files{i}));
                tcf('show-img');
                figure('name','show-img');
                %imshow(A);
                %pause(0.5);
                imgs{i} = A;
            end
            tcf();
            %% write gif file
            gif_file = strcat(gifname,'.gif');
            gaps = 100;
            Lovinu = ["我爱你","无畏人海的拥挤","用尽余生的勇气",...
                "只为能靠近你","哪怕一厘米","爱上你",...
                "是我落下的险棋","不惧岁月的更替","往后的朝夕"];
            
            text_index = 1;
            
            for i = 1:1:length(imgs)
                if isequal(i,1)
                    curA = imgs{i};
                    [curA,map] = rgb2ind(curA,256);
                    imwrite(curA,map,gif_file,'LoopCount',inf,...
                        'DelayTime',gaps*1e-3);
                else
                    curA = imgs{i};
                    % compute text index
                    if (mod(i,int32(length(imgs)/length(Lovinu)))==0)
                        text_index = text_index + 1;
                    end
                    curA = insertText(curA,[200 300],char(Lovinu(text_index)),'FontSize',100,...
                        'Font','SimSun','TextColor',[189,32,32],...
                        'AnchorPoint','LeftBottom',...
                        'BoxColor',[0.94,0.92,0.92],'BoxOpacity',0.0);
                    
                    [curA,map] = rgb2ind(curA,256);
                    imwrite(curA,map,gif_file,'WriteMode','append',...
                        'DelayTime',gaps*1e-3);
                end
            end
            cprintf('comment','write file finished\n');
        end
    end
end