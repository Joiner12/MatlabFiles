%{
    call python moudle 
%}
%% check search path
clc;
if count(py.sys.path,'') == 0
    fprintf('not in search path\n');
    insert(py.sys.path,int32(0),'');
end
% data type 
A = py.list({'a','b'});
b = py.py_R1.muClass();
c = b.callMe();