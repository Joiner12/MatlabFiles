%% Dg 
%{
    生成彩色马赛克图案
%} 
clc;
fprintf('Generate Figure and Show\n');
Dg_1()

%%
function Dg_1()
    clc;
    try
        close("GROD");
    catch
        fprintf('ere\n')
    end
    figure('name','GROD')
    a = rand(800);
    image(a,'CDataMapping','scaled');
    colorbar off;
    axis off;
    axis equal;
    box off;
%     background none;
end