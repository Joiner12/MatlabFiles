clc;

%{
    
%}
if false
    pythonPath = 'D:\Python_M\Code\PythonDA';
    dirpath = 'H:\MatlabFiles\Blocks\WallPaperHandle';
else
    pythonPath = 'D:\Codes\Python_MS\WallPaperModify';
    dirpath = 'D:\Codes\MatlabFiles\Blocks\WallPaperHandle';
end
% T3 Demo code
gridPic = GridPicture(fullfile(dirpath,'2.jpg'),[1,2]);
% add script search path
if false
    txt_file = fullfile(dirpath,'wenben.txt');
    bg_pic = fullfile(dirpath,'win10-wallpaper-bg.jpg');
    tar_pic = fullfile(dirpath,'wordcloud.jpg');
    pathInsert(pythonPath,1);
    py.WcMaker.Gen_WordCloud(txt_file,bg_pic,tar_pic)
end

%% 
source='cloud.jpg';
target='2-grid.jpg';
result='result3.jpg';
I1 = imread(source);            % SOURCE IMAGE
I2 = imread(target);        % DESTINATION IMAGE
PIE_Gui(I1,I2,result,1,0);

%%
CatPicture('result3.jpg')
%%
function pathInsert(tarPath,handleMode)
switch handleMode
    case 0
        % search path
        sp = py.sys.path();
        sp = cell(sp);
        searchList = strings(0);
        for op = 1:1:length(sp)
            temp = char(sp{op});
            searchList(op) = temp;
            fprintf('path-%0.0f:%s\n',op,temp);
        end
    case 1
        % 修改配置文件路径
        if (count(py.sys.path,tarPath)==0)
            insert(py.sys.path,int32(0),tarPath)
            fprintf('insert path:%s\n into sys.path\n',tarPath);
        else
            fprintf('path:%s exists in search\n',tarPath);
        end
    otherwise
        % did nothing
        fprintf('default block called\n');
        
end
end