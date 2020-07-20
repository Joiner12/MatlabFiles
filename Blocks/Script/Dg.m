function Dg()
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