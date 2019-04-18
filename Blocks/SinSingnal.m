%% sin datas generator
%{
    �ض�Ƶ�������źŷ�����
%}
function [SinSg] = SinSingnal(length,fre,amp,noise)
    clc;
    fprintf('�����źŷ�����,����%d\tƵ��%d\t��ֵ%d\t����%d\n', ...
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
        title('�����ź�')
        plot(tick,SinSg)
        hold on
        plot(tick,SinSgN)
        legend('Sin','Sin Noise')
        xlabel('t/s');ylabel('|');
        grid on
    end
end