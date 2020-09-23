%LSPB  Linear segment with parabolic blend
%
% [S,SD,SDD] = LSPB(S0, SF, M) is a scalar trajectory (Mx1) that varies
% smoothly from S0 to SF in M steps using a constant velocity segment and
% parabolic blends (a trapezoidal velocity profile).  Velocity and
% acceleration can be optionally returned as SD (Mx1) and SDD (Mx1)
% respectively.
%
% [S,SD,SDD] = LSPB(S0, SF, M, V) as above but specifies the velocity of 
% the linear segment which is normally computed automatically.

function [s,sd,sdd] = lspb(q0, q1, t, V)

    if isscalar(t)
        t = (0:t-1)';
    else
        t = t(:);
    end

    tf = max(t(:));

    if nargin < 4
        % if velocity not specified, compute it
        V = (q1-q0)/tf * 1.5;
    else
        V = abs(V) * sign(q1-q0); % 判断实际速度符号
        if abs(V) < abs(q1-q0)/tf
            error('V too small');
        elseif abs(V) > 2*abs(q1-q0)/tf
            error('V too big');
        end
    end
    
    if q0 == q1      % 目标位置和起始位置相同            
        s = ones(size(t)) * q0;
        sd = zeros(size(t));
        sdd = zeros(size(t));
        return
    end

    tb = (q0 - q1 + V*tf)/V;  % 计算匀加减速段时间
    a = V/tb;

    s = zeros(length(t), 1);
    sd = s;
    sdd = s;
    
    for i = 1:length(t)
        tt = t(i);

        if tt <= tb           % 匀加速段
            % initial blend
            s(i) = q0 + a/2*tt^2;
            sd(i) = a*tt;
            sdd(i) = a;
        elseif tt <= (tf-tb)  % 匀速段
            % linear motion
            s(i) = (q1+q0-V*tf)/2 + V*tt;
            sd(i) = V;
            sdd(i) = 0
        else                  % 匀减速段
            % final blend
            s(i) = q1 - a/2*tf^2 + a*tf*tt - a/2*tt^2;
            sd(i) = a*tf - a*tt;
            sdd(i) = -a;
        end
    end