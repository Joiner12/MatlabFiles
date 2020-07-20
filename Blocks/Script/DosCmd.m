%---------------------Path---------------------%
% filepath
if false
    clc;
    targetPath = 'H:\MatlabFiles\Blocks';
    if ~isequal(targetPath,pwd)
        cd(targetPath);
    end
    fprintf('load path....\n%s\n',pwd);
end
%---------------------DOSCMD---------------------%
%%
%{
    Specifiction:
    1.dos cmd instruction
%}
% dos
fprintf('draw figure finished...\n%s\n',datestr(datetime('now')));
figure(1)
pause(1)
close all
while trues
    pause(1);
    lrc();
end
% fprintf("pause state press any key to exit...\n")
% pause();
exit;
if false
    Cmd_Cd = 'dir';
    Cmd_PWD = 'pwd';
    [status,cmdout] = dos(Cmd_Cd);
    [status,cmdout] = dos(Cmd_PWD);
    
    % system
    sys_cd = 'dir';
    [status,cmdout] = system(sys_cd);
    
    sys_ls = 'cd';
    [status,cmdls] = system(sys_ls);
else
    
end
