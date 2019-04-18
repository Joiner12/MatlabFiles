function[itae,sigma] = model_01(kp,ki,kd)
    %---------- ϵͳ����
    ts = 1e-3;
    sys = tf(1,[0.02,1,0]);
    dsys = c2d(sys,ts,'z');
    [num,den] = tfdata(dsys,'v');

    %--------��������
    time = zeros(0);
    yd = zeros(0);
    u = zeros(0);
    y = zeros(0);
    error = zeros(0);

    %-------���̲���
    u_1 = 0.0;u_2 = 0.0;%���������
    y_1 = 0.0;y_2 = 0.0;%���ض������
    x = [0,0,0]';
    error_1 = 0;
    dltper_1 = 0;
    itae = 0;
    
    for k = 1:1:1000
        time(k) = k*ts;
        yd(k) = 4;% ��Ծ����

        %---------������ģ��
        u(k) = kp*x(1) + kd*x(2) + ki*x(3);
        if 0
                if abs(u(k))>100
                if u(k)>0
                    u(k) = 100;
                else
                    u(k) = -100;
                end
            end
        end
        %------����ģ��
    %     y(k) = -(den(2)*y_1 + den(3)*y_2 + den(4)*y_3)+ num(2)*u_1...
    %         + num(3)*u_2 + num(4)*u_3;
        y(k) = -(den(2)*y_1 + den(3)*y_2 )+ num(2)*u_1 + num(3)*u_2 ;
        error(k) = yd(k) - y(k);

        %-----���̲���
        u_2 = u_1;u_1 = u(k);
        y_2 = y_1;y_1 = y(k);

        x(1) = error(k);% kp
        x(2) =(error(k) - error_1)/ts ;%kd
        x(3) = x(3) + error(k)*ts;%ki
        error_1 = error(k);
        %---------ITAEָ��
        if 1
            itae = (1/2)*ts*time(k).*(error_1)^2 + dltper_1;
            dltper_1 =  itae;           
        end        
    end
    %-------������
    if max(y)>yd(1)
        sigma =  100*(max(y)-yd(1))/yd(1);
	else
		sigma = 0;
    end
end