%% 
function ModifyCurFigProperties()
    set(get(gca, 'Title'), 'Fontsize', 16);
    set(get(gca, 'XLabel'), 'Fontsize', 15);
    set(get(gca, 'YLabel'), 'Fontsize', 15);
    %% set default linewidth
    set(groot,'defaultLineLineWidth',1.5)
    grid minor
end