%{
    函数说明：
    @funcname:最速综合函数(fhan())
    
    @param:u,输入信号
    @param:x1 = xt(k) 跟踪信号；
    @param:x2 = xd(k) 微分信号；
    @param:delta,速度因子,控制跟踪收敛速度，调节delta即可获得；
    @param:h,积分步长

    reference:
    [1] 韩京清，武利强，TD滤波器及其应用
    [2] 张海丽，张宏立，微分跟踪器的研究与应用，化工自动化及仪表，2013，40（04），474-477
    [3] 张岱峰, 罗彪, 梅亮. 基于PD-ADRC的四旋翼控制器设计[J]. 测控技术, 2015, 34(12):62-65.
 %}
function f = fst_m(u,x1,x2,delta,h)
    d = delta*h;
    d0 = d*h;
    y = x1 - u + h*x2;
    a0 = sqrt(d^2 + 8*delta*abs(y));

    if abs(y) > d0
        a = x2 + (a0 - d)/2*sign(y);
    else
        a = x2 + y/h;
    end

    if abs(a) > d
        f = -delta*sign(a);
    else
        f = -delta*a/d;
    end