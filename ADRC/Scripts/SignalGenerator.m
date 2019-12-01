function [Signal,Signal_wgn] = SignalGenerator(figureFlag,signalNumber)
fprintf('generate signal script called...\n');
% 生成各种原始信号
% tdtest = zeros(2,5000);
Signal = zeros(0);
Signal_wgn = zeros(0);
switch signalNumber
    case 1
        try
            origin = load('H:\MatlabFiles\过棱\errbeforelimit_1.txt');
            Signal = origin';
            Signal_wgn = zeros(size(Signal));
            if figureFlag
                figure
                plot(Signal)
            end
            
        catch EM
            fprintf('%s\n',EM.Identifier);
        end
        
    case 2
        
        fprinf('Nothing here %d\n',signalNumber);
    otherwise
        basefre = 1;
        % Step_1 = zeros(1,1000);
        One_1 = ones(1,200);
        Zero_1 = zeros(1,200);
        Stair_1 = [Zero_1,7500.*One_1,5000.*One_1,2500.*One_1,5000.*One_1];
        
        t = linspace(0,1,1000);
        Sin_1 = 2500*sin(2*basefre*pi.*t) + 5000;
        Sin_2 = 2500*sin(2*5*basefre*pi.*t) + 5000;
        Sin_3 = 2500*sin(2*10*basefre*pi.*t) + 5000;
        Sin_4 = 2500*sin(2*20*basefre*pi.*t) + 5000;
        Signal = [Stair_1,Sin_1,Sin_2,Sin_3,Sin_4];
        Signal_wgn = zeros(size(Signal));
        if true
            Signal_wgn = wgn(1,5000,40)+ Signal;
        end
        if figureFlag
            figure
            subplot(221)
            plot(t,Sin_1)
            hold on
            plot(t,Sin_2)
            hold on
            plot(t,Sin_3)
            hold on
            plot(t,Sin_4)
            grid minor
            subplot(222)
            plot(linspace(0,5,5000),Signal)
            grid minor
            subplot(223)
            plot(Stair_1)
            grid minor
            subplot(224)
            %     global Signal_wgn;
            
            plot(Signal)
            hold on
            plot(Signal_wgn)
            set(get(gca, 'Legend'), 'String',["signal","wgn"]);
        end
        clearvars -except Signal Signal_wgn
end


