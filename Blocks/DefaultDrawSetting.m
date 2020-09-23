%% 设置默认绘图格式
function DefaultDrawSetting()
cprintf('comment','Modify Default Draw Properties!\n');
set(groot,'defaultLineLineWidth',2)

%% Text Size
set(groot,'DefaultAxesFontsize',14);
set(groot,'DefaultTextFontsize',18);
% set(groot,'DefaultAxesFontWeight','bold');
% set(groot,'DefaultTextFontWeight','bold');

%% Text Fonts
if(false)
    set(groot,'DefaultTextFontname','Arial')
    set(groot,'DefaultAxesFontname','Arial')
else
    set(groot,'DefaultTextFontname','DialogInput')
    set(groot,'DefaultAxesFontname','DialogInput')
end
end