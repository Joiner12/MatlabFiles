%% Slider Function
% rand queue & dynamic filter
% @dataIn：real time single value
% @initflag:first operat flag
% @sliderscope:slider window size
% @dataOut:real time single out value
function [dataOut] = SliderFilter(dataIn,sliderscope,initflag)
        nSliderScope =  sliderscope; % 滑动窗口
        persistent nSliderQue % 变量

        persistent nQueuePos % 环形列队
        % 初始化标志
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
