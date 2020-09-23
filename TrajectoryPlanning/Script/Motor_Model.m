%% motor model block
%{
    @parameter:curPos(mm)
    @parameter:vel(mm/ms)
    @parameter:nextPos(mm)
%}
function nextPos = Motor_Model(vel,curPos)
motion_T = 1;
nextPos = curPos + vel*motion_T;
end