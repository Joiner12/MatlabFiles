function GetESO()
%{
    β1 = 3*ω0，β2 = 3*ω0^2 β3 = ω0^3,ω0是观测器带宽(rad/s)，
    kp = wc^2 kd = wc,wc是控制器带宽(rad/s)
%}
mode = input('ladrc mode:1,adrc mode:2\n');
w0 = input('Set ESO Bandwidth:');
switch mode
    case 1
        beta_1 = 3*w0;
        beta_2 = w0*beta_1;
        beta_3 = w0*w0*w0;
        
        fprintf('Bandwidth of ESO is %.2f rad/s,beta_1:%.2f,beta_2:%.2f,beta_3:%.f\nESO Params:%.f,%.f,%.f\n'...
            ,w0,beta_1,beta_2,beta_3,beta_1,beta_2,beta_3);
        % fprintf('Bandwidth of ESO is %d rad/s,kp:%d,kd:%d\n Control Params:%d,%d\n'...
        %     ,wc,kp,kd,kp,kd);
        
        a = GetAlpha(1,1);
        % fprintf('\nthis\na\n%d\n',a)
    case 2
        beta_1 = 3*w0;
        beta_2 = w0*beta_1/5;
        beta_3 = w0*w0*w0/9;
        
        wc = 0;
        kp = wc^2;
        kd = 2*wc;
        fprintf('Bandwidth of ESO is %.2f rad/s,beta_1:%.2f,beta_2:%.2f,beta_3:%.f\nESO Params:%.f,%.f,%.f\n'...
            ,w0,beta_1,beta_2,beta_3,beta_1,beta_2,beta_3);
        
    otherwise
       fprintf('nothing\n')
end


end


%{
    LADRC，α系数
%}
function cof = GetAlpha(deg,alpha)
num = factorial(deg+1);
den = factorial(alpha)*factorial(deg+1-alpha);
cof = num/den;
end