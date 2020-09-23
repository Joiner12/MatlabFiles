%% ¸úËæµ½Î»
%{
    parameter:
    err:follow error(mm)
    followScope (mm)
    followedDelay(ms)
%}
function followed = HasFollowed(err,followScope,followedDelay)
global FollowCnt;
bRet  = false;
if abs(err) <= followScope
    FollowCnt = FollowCnt + 1;
else
    if FollowCnt > 0
        FollowCnt = FollowCnt - 1;
    else
        FollowCnt = 0;
    end
end

if FollowCnt >= followedDelay
    bRet = true;
else
    bRet = false;
end

followed = bRet;
end