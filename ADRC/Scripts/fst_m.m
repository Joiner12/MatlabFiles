%{
    ����˵��:
    @Funcname:�����ۺϺ�������(fhan())
    ADRC�����Ժ���Сģ��,ʵ�����ٸ���;
    ����:
    @Param:x1 = xt(k) �����ź�(����״̬)
    @Param:x2 = xd(k) ΢���ź�(΢��״̬)
    @param:u �����ź� 
    @param:r �ٶ�����,���Ƹ��������ٶȣ�����r���ɻ��;
    @param:h�����ֲ���

    ==========================================================================
    reference: 
    [1] H:\MatlabFiles\WavePanel\Scripts\TD_R2.m
    [2] H:\MatlabFiles\WavePanel\Scripts\TD_R3.m
    [3] �����壬����ǿ��TD�˲�������Ӧ��
    [4] �ź������ź�����΢�ָ��������о���Ӧ�ã������Զ������Ǳ�2013��40��04����474-477
    [5] ��᷷�, �ޱ�, ÷��. ����PD-ADRC����������������[J]. ��ؼ���, 2015, 34(12):62-65.
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