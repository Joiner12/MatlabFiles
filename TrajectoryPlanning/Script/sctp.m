%% S-curve trajectory planning function
%{
    1. The S-shaped speed curve generally includes:
    acceleration �� uniform acceleration �� deceleration �� uniform speed
    �� acceleration �� deceleration �� uniform deceleration �� and deceleration.
    There are 7 segments in total, so it is also called 7-segment curve. 

    3. S-curve algorithm steps
    a) First judge whether the maximum speed can be reached

    For the acceleration section, if the planned maximum acceleration amax is not reached, then:
%}
function [pos,vel,acc,jerk] = sctp(p0,p1,v0,v1)
    %% constraint paramters mm | ms 
    vmax = 1; 
    amax = 10; 
    jmax = 10;
    %% segment 1 �Ӽ��ٽ׶�

    %% segment 2 �ȼ��ٽ׶�

    %% segment 3 �����ٽ׶�

    %% segment 4 ���ٽ׶�

    %% segment 5 �Ӽ��ٽ׶�

    %% segment 6 �ȼ��ٽ׶�

    %% segment 7 �����ٽ׶�

end