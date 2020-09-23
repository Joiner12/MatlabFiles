%% 
%{
    ���ٶȵ�������
    v^2/(2*a) > s
    @funcname:AccRegulator
    @param:CurVel(mm/ms)
    @param:SetAcc(mm/ms^2)
    @param:RemL(mm)
%}
function [AccRegulated,EnableFlag] = AccRegulator(CurVel,SetAcc,RemL)
    T = 1; % ��������
    EnableFlag = false;
    AccRegulated = SetAcc;
    if false
        minDecAcc =  power(CurVel,2)/2/(RemL - CurVel*T);
    else
        minDecAcc =  power(CurVel,2)/2/(RemL);
    end
    if (minDecAcc > SetAcc)
        EnableFlag = true;
        AccRegulated = minDecAcc;
        % ���ٶ����� 2*accset
        accLimiter = 1*SetAcc;
        if AccRegulated > accLimiter
            AccRegulated = accLimiter;
        end
    end
end

function stdAcc = ConvertG2StdAcc(g)
    stdAcc = 9.8/1e3.*g;
end