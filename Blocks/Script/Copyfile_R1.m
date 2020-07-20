%% filepath
clc;
targetPath = 'H:\MatlabFiles\Blocks';
if ~isequal(targetPath,pwd)
    cd(targetPath);
end
fprintf('load path....\n%s\n',pwd);

%%  Copy Files
des = 'C:\Users\Whtest\Desktop\CopyHandle\DES';
src = 'C:\Users\Whtest\Desktop\CopyHandle\SRC';
src_detail = dir(src);

for i=1:1:length(src_detail)
    if contains(src_detail(i).name,'txt')
        status = copyfile(fullfile(src_detail(i).folder,src_detail(i).name),des);
        fprintf('%.0f\n',status);
    end
end
