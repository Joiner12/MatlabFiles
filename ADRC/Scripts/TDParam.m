%{
    等效线性微分跟踪器参数
    ωn = R*sqrt(k1),epsilon = k2/2/sqrt(k1)
%}
function TDParam(k1,k2,R)
    clc;
    fprintf('k1,k2,R:\t%.0f,%.0f,%.0f\n',k1*10,k2*10,R);
    wn = R*sqrt(k1);
    epsilon = k2/(2*sqrt(k1));
    fprintf("wn,epsilon:\t%.2f,%.2f\n",wn,epsilon)
end