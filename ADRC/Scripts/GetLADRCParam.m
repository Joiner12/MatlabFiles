function GetLADRCParam(w0)
%{
    ¦Â1 = 3*¦Ø0£¬¦Â2 = 3*¦Ø0^2 ¦Â3 = ¦Ø0^3,¦Ø0ÊÇ¹Û²âÆ÷´ø¿í£¬
%}
    beta_1 = w0*w0;
    beta_2 = 3*beta_1;  
    beta_3 = w0*beta_1;
    fprintf('bandwidth of eso is %d rad/s,beta_1:%d,beta_2:%d,beta_3:%d\nParams:%d,%d,%d\n'...
        ,w0,beta_1,beta_2,beta_3,beta_1,beta_2,beta_3);
end