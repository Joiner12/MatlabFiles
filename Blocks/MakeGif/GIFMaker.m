%% gif maker
classdef GIFMaker
    methods(Static)
        
        function ConvertVideoToGif(video_file)
            tic;
            if ~isfile(video_file)
                print('no such file,check file..\n')
                return
            end
            % readvideo
%             playCtrl = input('ÊÇ·ñ²¥·Å£º')
            if false
                implay(video_file)
            end
            %
            vobj = VideoReader(video_file);
            vobj_f = read(vobj,[137,197]);
            
            % write gif
            for i=1:1:length(vobj_f)
                
            end
            toc
        end
        
    end
end