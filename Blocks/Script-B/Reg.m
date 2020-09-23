%% regexp
clc;
Param = ["CodePratice/NodeTree.cpp"...
        "CodePratice/Rope.h"...
        "EX3/EX33.h"...
        "Src/main.cpp"];

for index_i = 1:1:length(Param)
    exp = 'EX3/.*';
    ans_i = regexp(Param(index_i),exp,'match');
    if ~isempty(ans_i)  
        ans_i
    end
end