%% sin datas generator
%{
    特定频率正弦信号发生器
%}
function [SinSg] = SinSingnal(length,fre,amp,noise)
    clc;
    fprintf('正弦信号发生器,长度%d\t频率%d\t幅值%d\t噪声%d\n', ...
        length,fre,amp,noise );
    SinSg = zeros(0);
    tick = zeros(0);
    SinSgN = zeros(0);
    
    for i = 1:1:length
        SinSg(i) = sin((i-1)*10*pi/length);
        tick(i) = 1/fre*(i-1);
    end
    if isequal(noise,1)
        rng(0,'twister');
        SinSgN = SinSg + amp*(rand(size(SinSg)) - 0.5)/20;
%     amp*(rand(3,1) - 0.5)/10    
    end
    
    %
    if ~isequal(tick,0) && ~isequal(SinSg,0)
        figure
        title('正弦信号')
        plot(tick,SinSg)
        hold on
        plot(tick,SinSgN)
        legend('Sin','Sin Noise')
        xlabel('t/s');ylabel('|');
        grid on
    end
end