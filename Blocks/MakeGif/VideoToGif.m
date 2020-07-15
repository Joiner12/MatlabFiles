%% make gif from video
clc;
close all;
if false
[file,path] = uigetfile('C:\Users\10520\Desktop\*.mp4;*.avi}');
else
    file = '20200625_132148.mp4';
    path = 'C:\Users\10520\Desktop';
end
%%
clc;
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
    a = image(vobj_f(:,:,:,i),'Parent',axes_frame);
    im{i} =  frame2im(getframe(gca));
end
fprintf('transfer to figure frame finieshed\n')
% wirte to gif file
gif_file = 'CurGif.gif';
gap = 1;
for j = 1:gap:length(im)
    [A,map] = rgb2ind(im{j},256);
    if j==1
        imwrite(A,map,gif_file,'LoopCount',...
            inf,'DelayTime',gap/vobj.FrameRate);
    else
        imwrite(A,map,gif_file,'WriteMode',...
            'append','DelayTime',gap/vobj.FrameRate);
    end
end
fprintf('from video:%s to gif:%s finished\n',file,gif_file);

%% 
clc;
GIFMaker.ConvertVideoToGif('20200625_132148.mp4')

