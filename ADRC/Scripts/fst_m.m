%{
    函数说明:
    @Funcname:最速综合函数函数(fhan())
    ADRC非线性函数小模块,实现最速跟踪;
    参数:
    @Param:x1 = xt(k) 跟踪信号(被控状态)
    @Param:x2 = xd(k) 微分信号(微分状态)
    @param:u 输入信号 
    @param:r 速度因子,控制跟踪收敛速度，调节r即可获得;
    @param:h，积分步长

    ==========================================================================
    reference: 
    [1] H:\MatlabFiles\WavePanel\Scripts\TD_R2.m
    [2] H:\MatlabFiles\WavePanel\Scripts\TD_R3.m
    [3] 韩京清，武利强，TD滤波器及其应用
    [4] 张海丽，张宏立，微分跟踪器的研究与应用，化工自动化及仪表，2013，40（04），474-477
    [5] 张岱峰, 罗彪, 梅亮. 基于PD-ADRC的四旋翼控制器设计[J]. 测控技术, 2015, 34(12):62-65.
    [6] 
%}
function f = fst_m(u,x1,x2,r,h)
    d = r*h;
    d0 = h*d; % d0 = r*h*h
    y = x1 - u + h*x2;
    a0 = sqrt(d^2+8*r*abs(y));

    if abs(y) > d0
        a = x2+(a0-d)/2*sign(y);
    else
        a = x2+y/h;
    end

    if abs(a)>d
        f = - r*sign(a);
    else
        f = - r*a/d;
    end
end