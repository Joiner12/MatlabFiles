%% manage python search path
function ManagePythonPath(tarPath,handleMode)
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
        % �޸������ļ�·��
        if (count(py.sys.path,tarPath)==0)
            insert(py.sys.path,int32(0),tarPath)
            fprintf('insert path:%s\n into sys.path\n',tarPath);
        else
            fprintf('path:%s exists in search\n',tarPath);
        end
    otherwise
        % did nothing
        % �޸������ļ�·��
        if (count(py.sys.path,tarPath)==0)
            insert(py.sys.path,int32(1),tarPath)
            fprintf('insert path:%s\n into sys.path\n',tarPath);
        else
            fprintf('path:%s exists in search\n',tarPath);
        end
        % search path
        sp = py.sys.path();
        sp = cell(sp);
        searchList = strings(0);
        for op = 1:1:length(sp)
            temp = char(sp{op});
            searchList(op) = temp;
            fprintf('path-%0.0f:%s\n',op,temp);
        end
end
end