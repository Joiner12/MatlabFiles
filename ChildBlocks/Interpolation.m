%% Interpolation Algorithm
%{
    @parameter: Acc : UnitStep
    @parameter: V_max : UnitStep
    @parameter: t_Resv : ms (��������)
	@parameter: SliderScope : ��������
	@parameter��MoveL : UnitP
	@parameter: run_time : ms(��������)
	�������� : 0.5ms
%}
function [tick,vel,rem] = Interpolation(Acc,V_max,t_Resv,SliderScope,MoveL)
%----- Initialization
CurSpeed = 0;
RemL = MoveL;
OperatGap = 1;
vel = zeros(0);
firstrun = 1;
run_time = 0;
rem = zeros(0);
%----- main
ver = 0; % �汾
if ver
	while((CurSpeed) > 0 || isequal(firstrun,1))
		moveFlag = 0;
		firstrun = 0;

		if ((CurSpeed+2*Acc)*(CurSpeed+Acc)/(2*Acc) < RemL)
			moveFlag = 1; %����
		elseif ((CurSpeed+Acc)*CurSpeed/(2*Acc) > RemL)
			moveFlag = -1; %����
        end
		run_time = run_time + 1;
        rem(run_time) = RemL;
        RemL = RemL - CurSpeed*OperatGap;
       
		vel(run_time) = CurSpeed;
		CurSpeed = CurSpeed +  Acc*moveFlag;
		% ����
		if (CurSpeed >= V_max)
			CurSpeed = V_max;
		end
		
	end
else
	k = 0; % CurSpeed�滻��K
% 	while(RemL >= 0 || isequal(firstrun,1))]
    while(RemL >= 0 && CurSpeed >= 0)
		moveFlag = 0;
		firstrun = 0;
		% ����ʱ��
		k = CurSpeed/Acc + t_Resv;
		if (k + 2)*(k + 1)*Acc/2 < RemL
			moveFlag = 1; %����
		elseif (k + 1)*k*Acc/2 > RemL
			moveFlag = -1; %����
        end
        run_time = run_time + 1;
        % �����˲�
%         CurSpeed = SliderFilter(CurSpeed,SliderScope,run_time);
		RemL = RemL - CurSpeed*1;
%         RemL = int32(RemL);
		rem(run_time) = RemL;
		vel(run_time) = CurSpeed;
		CurSpeed = CurSpeed +  Acc*moveFlag;
% 		CurSpeed = int32(CurSpeed);	
      
        % ����
        if moveFlag == -1
           if  CurSpeed < Acc && RemL> 0
               CurSpeed = Acc;
% 			   CurSpeed = int32(CurSpeed);
           end
        end
		% ����
		if (CurSpeed >= V_max)
			CurSpeed = V_max;
		end
		% ��ֹ������ѭ��
        if run_time > 2e3
            break;
        end
    end
    tick = run_time;
end
%{
close all;
figure
plot(vel)
%}
%---- stop condition----
end