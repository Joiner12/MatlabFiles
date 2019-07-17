%{
    安排过渡过程函数
    trans(T0,t) =   {1/2(1+sin(pi*(t/T0 - 1/2))) ,t<T0
                    {1                           ,T>t0

    T0：过渡周期
%}
function [] = trans(T0,figureflag,Amp)
    
    if T0 <= 0
        fprintf('T0 should be a positive value\n');
        return
    end
    disp('Trans function called....')
    t = 0:T0/20:T0;
    out = 0.5*Amp*(1+sin(pi*(t./T0 - 1/2)));
    if figureflag
        figure
        plot(t,out)
        title('Trans-安排过渡过程函数')
        grid on;xlabel('t');ylabel('out')
    end
end