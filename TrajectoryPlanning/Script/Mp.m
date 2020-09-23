%% 运动规划算法

classdef Mp
    %% 速度插补算法——T型速度规划
    %{
        1.改进T型速度规划算法
        减速延时：reserve time
        输出滑动滤波：moving slider filter
        @function name:Interplt
    %}
    
    methods (Static)
        function  [vel,remL] = Interplt(A_max,V_max,curV,tarL,t_Reserve,s_Scope)
            tarLCpt = tarL;
            if false % enable accregulator
                if abs(tarLCpt) > (curV^2)/2/A_max % mm
                    tarLCpt = (curV^2)/2/A_max;
                end
            end
            
            vel = StepOn(A_max,V_max,curV,tarLCpt,t_Reserve);
            remL = tarLCpt - vel;
            if remL <= 0
                remL = 0;
                cprintf('comment','motion planning finished.\n');
            end
        end
    end
    %%  速度插补算法——改进 T型速度规划
    methods (Static)
        function [interpOutVel] = InterP_T(curV,tarL)
            global Acc VMax WhileCnt;
            global MAFData t_Reserve Vels_INofilter;
            global Interped OutInterped;
            
            cacheL = Interped - OutInterped;
            tarLTemp = tarL;
            %{
                if (_nRem <= _nAcc)
                {
                    _next = _nRem;
                }
                else if (_cur == 0)
                {
                    _next = _nAcc;
                }
                else
                {
                    _next = _cur;
                }
            %}
            %             tarLTemp = tarL - cacheL;
            %             if tarLTemp < 0
            %                 tarLTemp  = 0;
            %             end
            vel = StepOn(Acc,VMax,curV,tarLTemp,t_Reserve);
            Interped =  Interped + vel;
            [MAFData,interpOutVel] =  MovingFilter_M(MAFData,vel);
            OutInterped = OutInterped + interpOutVel;
            
            Vels_INofilter(WhileCnt) = vel;
            if tarL - interpOutVel <= 0
                cprintf('comment','interp process finished.\n');
            end
        end
    end
end

function nextVel = StepOn(A_max,V_max,curVel,tarL,t_Reserve)
% global A_max V_max t_Reserve s_Scope;
k = 0;
% 减速时间
k = curVel/A_max + t_Reserve;
if k < 0
    k = 0;
end
% 加速
if (k + 2)*(k + 1)*A_max/2 <= tarL
    nextVel = curVel + A_max;
    % 减速
elseif (k + 1)*k*A_max/2 >= tarL
    nextVel = curVel - A_max;
    if(nextVel < A_max && tarL > 0)
        nextVel = A_max;
    end
    % 保持原有速度
else
    % 最小规划限制
    stableVelTemp = 0;
    if tarL <= A_max
        stableVelTemp = tarL;
    elseif tarL == 0
        stableVelTemp = A_max;
    else
        stableVelTemp = curVel;
    end
    nextVel = stableVelTemp;
end

% 最大速度限制
if nextVel > V_max
    nextVel = V_max;
end
if (nextVel > tarL)
    
    nextVel = tarL;
end
if nextVel<0
    nextVel = 0;
end
% cprintf('Comment','\rStepOn called.\n')
end