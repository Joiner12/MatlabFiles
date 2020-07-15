%% General Use is not enough
classdef GifMake
    methods (Static)
        % from gif to gif
        function  CutFromGif()
            fprintf('handle gif files\n');
            filename = '1.gif';
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
            close all;
            if false
                [file,path] = uigetfile('C:\Users\10520\Desktop\*.mp4;*.avi}');
            else
                file = '20200625_132148.mp4';
                path = pwd;
            end
            %
            fprintf('create video obj from %s\n',fullfile(path,file))
            % check frames
            if true && false
                implay(fullfile(path,file));
            end
            if ~iscell(file)
                vobj = VideoReader(fullfile(path,file));
            end
            vobj_f = read(vobj,[137,197]);
            
            % transfer video frame to figure frame
            axes_frame = axes;
            axes_frame.Visible = 'off';
            size_frame = size(vobj_f);
            im = cell(0);
            for i=1:1:size_frame(end)
                image(vobj_f(:,:,:,i),'Parent',axes_frame);
                im{i} =  frame2im(getframe(gca));
            end
            fprintf('transfer to figure frame finieshed\n')
            % wirte to gif file
            if contains(gifname,'.gif')
                gif_file = gifname;
            else
                gif_file = strcat(datetime('now','format','HHmmSS'),'.gif');
            end
            gap = 1;
            for j = 1:gap:length(im)+10
                if j==1
                    [A,map] = rgb2ind(im{j},256);
                    imwrite(A,map,gif_file,'LoopCount',...
                        inf,'DelayTime',gap/vobj.FrameRate);
                elseif j < length(im) - 5
                    [A,map] = rgb2ind(im{j},256);
                    imwrite(A,map,gif_file,'WriteMode',...
                        'append','DelayTime',gap/vobj.FrameRate);
                elseif j <= length(im)
                    [A,map] = rgb2ind(im{j},256);
                    imwrite(A,map,gif_file,'WriteMode',...
                        'append','DelayTime',gap/vobj.FrameRate);
                else
                    [A,map] = imread('2001w.jpg');
                    [A,map] = rgb2ind(A,256);
                    imwrite(A,map,gif_file,'WriteMode',...
                        'append','DelayTime',gap/vobj.FrameRate);
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
end