%% 电容传感器偏差度
function Cbias = CapBias(deltaE,deltaC,CacheData)
    if nargin == 2
        if isequal(deltaC,0) && isequal(deltaE,0)
            Cbias = 1;
        else
            Cbias = deltaC/deltaE;
        end
    end
    if nargin == 3
        CacheData(1,end) = [CacheData(1,2:end-1),deltaE];
        CacheData(2,end) = [CacheData(2,2:end-1),deltaC];
        Cbias = sum(CacheData(1,:))/sum(CacheData(2,:));
    end
end