%% pictures to gif
function PicsToGif(srcpath,tarpath,tarname)
[files,path] = uigetfile(fullfile(srcpath,'*.jpg;*.png'),...
    'Multiselect','on');
%% wirte to gif file
if contains(tarname,'.gif')
    gif_file = gifname;
else
    gif_file = strcat(char(datetime('now','format','HHmmSS')),'.gif');
end
%% read pictures 
if isempty(files)
    return;
end

im = cell(0);

for pic_cnt = 1:1:length(files)
    im{pic_cnt} = imread(fullfile(path,files{pic_cnt}));
end

%%
gap = 50;
for j = 1:1:length(im)
    if j==1
        [A,map] = rgb2ind(im{j},256);
        imwrite(A,map,fullfile(tarpath,gif_file),'LoopCount',...
            inf,'DelayTime',gap*0.001);
    elseif j < length(im) - 1
        [A,map] = rgb2ind(im{j},256);
        imwrite(A,map,fullfile(tarpath,gif_file),'WriteMode',...
            'append','DelayTime',gap*0.001);
    else
        [A,map] = rgb2ind(im{j},256);
        imwrite(A,map,fullfile(tarpath,gif_file),'WriteMode',...
            'append','DelayTime',0);
    end
end
end