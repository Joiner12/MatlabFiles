% path
if ~isequal(pwd,'H:\MatlabFiles\Blocks')
    cd H:\MatlabFiles\Blocks;
end
fprintf('load path...\n%s\n',pwd);

%% 
%{
    about sparse matrix
%}
clc;
A = rand(4,4);
A_S = sparse(A) 
A_F = full(A_S)
whos A_S
whos A_F
% plot(A,'*')