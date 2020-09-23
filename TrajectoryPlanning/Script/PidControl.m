%% propertion + velocity obserber
function pidVel = PidControl(kp,err,forwardRatio)
global Acc VMax ;
global preV ;
preVel = preV;
%     global MAFData t_Reserve;
pidVel = -1*kp*err/100 + forwardRatio*preVel;

% limit acc
if abs(pidVel - preVel) > Acc
    pidVel = sign(pidVel - preVel)*Acc + preVel;
end

% saturation
if abs(pidVel) > VMax
    pidVel = sign(pidVel)*VMax;
end
end