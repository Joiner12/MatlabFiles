if false
    %% make gif from video
    clc;
    if true
        GifMake.CutFromVideo(strcat('Video',char(datetime('now','format','HHmmSS')),'.gif'));
    else
        GifMake.CutFromGif();
    end
    
    %%
    clc;
    
    gif_file = 'w_200.gif';
    
    for i =1:1:5
        if isequal(i,1)
            [A,map] = imread('2000w.jpg');
            [A,map] = rgb2ind(A,256);
            imwrite(A,map,gif_file,'LoopCount',...
                inf,'DelayTime',1);
        else
            [A,map] = imread('2001w.jpg');
            [A,map] = rgb2ind(A,256);
            imwrite(A,map,gif_file,'WriteMode',...
                'append','DelayTime',1);
        end
    end
    % imshow(A)
    %%
    clc;
    GifMake.GridPictue('H:\MatlabFiles\Blocks\MakeGif\1.jpg')
end
%% cut gif
clc;
cprintf('comment','%s\n',char(datetime('now')));
GifMake.CutFromVideo('huashou');

%% 
PicsToGif('pic_temp','','')
