%% Slider Function
% rand queue & dynamic filter
% @dataIn��real time single value
% @initflag:first operat flag
% @sliderscope:slider window size
% @dataOut:real time single out value
function [dataOut] = SliderFilter(dataIn,sliderscope,initflag)
        nSliderScope =  sliderscope; % ��������
        persistent nSliderQue % ����

        persistent nQueuePos % �����ж�
        % ��ʼ����־
        if isequal(initflag,1)
             nSliderQue = zeros(nSliderScope,1);
             nQueuePos = 1;
        end
        
        nSliderQue(nQueuePos) = dataIn;% enter queue & out queue
        AvrOut = mean(nSliderQue);    
        nQueuePos = nQueuePos + 1;
        if mod(nQueuePos-1,nSliderScope)==0
            nQueuePos = 1;
        end
        
        dataOut = AvrOut;
end
