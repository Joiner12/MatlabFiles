%{
    @funcname:SignalGenerator
    @param:figureFlag,绘图开关
    @param:signalNumber,信号序号
    1:导入过棱数据
    2:1hz，赋值1000，数据大小100的标准正弦信号数据
    otherwise:不同正弦，阶梯数据
    

    @param:Signal,输出信号（无噪）
    @param:Signal_wgn,输出信号（含噪）

%}

function [Signal,Signal_wgn] = SignalGenerator(figureFlag,signalNumber)
fprintf('generate signal script called...\n');
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
        %{
            100 
            0,634,1266,1893,2511,3120,3717,4298,4862,
            5406,5929,6428,6901,7346,7761,8146,8497,8815,
            9096,9341,9549,9718,9848,9938,9989,9999,9969,
            9898,9788,9638,9450,9224,8960,8660,8326,7958,
            7557,7127,6668,6182,5671,5137,4582,4009,3420,
            2817,2203,1580,951,317,-317,-951,-1580,-2203,
            -2817,-3420,-4009,-4582,-5137,-5671,-6182,
            -6668,-7127,-7557,-7958,-8326,-8660,-8960,-9224,
            -9450,-9638,-9788,-9898,-9969,-9999,-9989,-9938,
            -9848,-9718,-9549,-9341,-9096,-8815,-8497,-8146,
            -7761,-7346,-6901,-6428,-5929,-5406,-4862,-4298,
            -3717,-3120,-2511,-1893,-1266,-634,0,
        %}
        t = linspace(0,1,100);
        basefre = 1;
        Sin_1 = 10000*sin(2*basefre*pi.*t);
        Sin_1 = int32(Sin_1);
        Signal = Sin_1;d
        Signal_wgn = 0;
        if figureFlag
            f1 = figure;
            f1.Name = 'sig-gen';
            plot(t,Sin_1)
            grid minor
        end
        fprintf('standard sine wave %d\n',1);
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


