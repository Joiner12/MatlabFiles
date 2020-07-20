%% install matalb Engine for Python API
clc;
root_path = matlabroot();
detail_path = 'extern/engines/python';
cur_path = pwd();
tar_path =fullfile(root_path,detail_path);
if true
    cd(tar_path)
    dos('python setup_1.py install')
    cd(cur_path)
else
    winopen(tar_path);
    return
end
