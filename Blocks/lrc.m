function lrc()
global dir_lrc;
global lrcSrcPath;
global lrcs;
lrcs = strings(0);
lrcSrcPath = strings(0);
%------------%
dir_lrc = dir('C:\Users\10520\Desktop\ned');

filepath = 'C:\Users\10520\Desktop\ned';
dir_path = dir(filepath);
if length(dir_path) < 2
    fprintf('dong dong dong /...\n');
end

lrc_size = length(dir_path);
file_pos = randi(lrc_size);
try
    fileId = fopen(fullfile(dir_path(file_pos).folder,dir_path(file_pos).name),'r',...
        'n','UTF-8');
    
    if fileId~=-1
        cnt = 1;
        while ~feof(fileId)
            tline = fgetl(fileId);
            ex = {'Made by LrcHelper','ve','弦乐编曲','作词:','制作人：','编曲 ：','吉他：'...
                '~~间奏~~','：'};
            if ~contains(tline,ex)
                try
                    pat = '\[.*?\]';
                    temp_1 = (tline);
                    temp_1 = (regexp(temp_1,pat,'match'));
                    temp_1 = temp_1{1};
                    temp_1 = strrep(tline,temp_1,'');
                    %             fprintf('%s\n',temp_1);
                    lrcs(cnt) = string(temp_1);
                    cnt = cnt + 1;
                catch
                    
                end
                
            end
        end
        try
            fprintf('%s\n',lrcs(randi([1 cnt])));
        catch
            fprintf('%s\n','=-===============');
        end
    end
    fclose(fileId);
catch
end
end