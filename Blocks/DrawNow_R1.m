%%
clc;
ScriptPath = 'D:\Codes\MatlabFiles\Blocks\';
if ~isequal(ScriptPath,pwd)
    cd(ScriptPath)
end
fprintf('����·��:%s\n',pwd);

%% 
% ����Drawnow����
clc;
h = animatedline;
x = linspace(-5*pi,5*pi,2000);
y = sin(x);
for i=1:1:length(x)
    addpoints(h,x(i),y(i));
    drawnow 
end