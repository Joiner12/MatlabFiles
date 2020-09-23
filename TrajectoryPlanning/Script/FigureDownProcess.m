% draw figure
function FigureDownProcess(~)
global MachineryPos Vels_I CapHs Vels_P CtrlModes;
global Vels_INofilter WhileCnt CtrlVels Accs;
global Acc;
% data
drawMachineryPos = MachineryPos;
drawMachineryPos = reshape(drawMachineryPos,[1,length(drawMachineryPos)]);

drawVels_I = Vels_I;
drawVels_I = reshape(drawVels_I,[1,length(drawVels_I)]);

drawCapHs = CapHs;
drawCapHs = reshape(CapHs,[1,length(drawCapHs)]);

drawVels_P = Vels_P;
drawVels_P = reshape(drawVels_P,[1,length(drawVels_P)]);

drawVels_Infact = CtrlVels;
drawVels_Infact = reshape(drawVels_Infact,[1,length(drawVels_Infact)]);

drawVels_Nofilter = Vels_INofilter;
drawVels_Nofilter = reshape(drawVels_Nofilter,[1,length(drawVels_Nofilter)]);

drawVels_Ctrlmode = CtrlModes;
drawVels_Ctrlmode = reshape(drawVels_Ctrlmode,[1,length(drawVels_Ctrlmode)]);

drawVels_Accs = Accs;
drawVels_Accs = reshape(drawVels_Accs,[1,length(drawVels_Accs)]);
if nargin < 1
    tcf('downsimu-1','downsimu-2','downsimu-3');
%     figure('name','downsimu-1','Position',[1921,31,1920,973]);
    figure('name','downsimu-1');
    subplot(231)
    plot(drawMachineryPos)
    ModifyCurFigProperties()
    set(get(gca, 'Title'), 'String', 'position');
    % cursorbar(gca,'CursorLineColor',[0.02 0.75 0.27]);
    subplot(232)
    plot(drawVels_I,'.-')
    hold on
    plot(drawVels_P,'--')
    hold on
    plot(drawVels_Infact)
    ModifyCurFigProperties()
    set(get(gca, 'Title'), 'String', 'Interp Vel');
    legend('interp','pid','real')
    
    subplot(233)
    plot(drawVels_Nofilter)
    hold on
    plot(drawVels_I)
    set(get(gca, 'Title'), 'String', 'pid vel');
    legend('no filter','filter')
    ModifyCurFigProperties()
    
    
    subplot(234)
    plot(drawCapHs)
    ModifyCurFigProperties()
    
    set(get(gca, 'Title'), 'String', 'Caph');
    %    dickbutt();
    
    subplot(235)
    plot(drawVels_Ctrlmode)
    set(get(gca, 'Title'), 'String', 'CtrlMode');
    ModifyCurFigProperties();
    
    subplot(236)
    plot(drawVels_Accs)
    hold on
    
    plot([1 length(drawVels_Accs) ],[Acc Acc])
    hold on 
    plot([1 length(drawVels_Accs) ],[-Acc -Acc])
    set(get(gca, 'Title'), 'String', 'acc');
    
    ModifyCurFigProperties();
    
else
    % new figure
    if WhileCnt==1
        tcf('downsimu-1','downsimu-2','downsimu-3');
        figure('name','downsimu-1','Position',[1921,31,1920,973]);
    else
        % refresh figure
        % figure('name','downsimu-1','WindowState','maximized');
        clf;
        subplot(231)
        plot(drawMachineryPos)
        ModifyCurFigProperties()
        set(get(gca, 'Title'), 'String', 'position');
        xlim([0 90])
        % cursorbar(gca,'CursorLineColor',[0.02 0.75 0.27]);
        subplot(232)
        plot(drawVels_I)
        hold on
        plot(drawVels_P)
        ModifyCurFigProperties()
        xlim([0 90])
        set(get(gca, 'Title'), 'String', 'Interp Vel');
        legend('interp','pid')
        
        subplot(233)
        plot(Vels_INofilter)
        hold on
        plot(drawVels_I)
        set(get(gca, 'Title'), 'String', 'pid vel');
        legend('no filter','filter')
        xlim([0 90])
        ModifyCurFigProperties()
        
        
        subplot(234)
        plot(drawCapHs)
        ModifyCurFigProperties()
        set(get(gca, 'Title'), 'String', 'Caph');
        %    dickbutt();
        xlim([0 90])
        subplot(235)
        plot(CtrlModes)
        set(get(gca, 'Title'), 'String', 'CtrlMode');
        ModifyCurFigProperties();
        xlim([0 90])
    end
end
end