%{
    ����˵����
    @funcname:�����ۺϺ���(fhan())
    
    @param:u,�����ź�
    @param:x1 = xt(k) �����źţ�
    @param:x2 = xd(k) ΢���źţ�
    @param:delta,�ٶ�����,���Ƹ��������ٶȣ�����delta���ɻ�ã�
    @param:h,���ֲ���

    reference:
    [1] �����壬����ǿ��TD�˲�������Ӧ��
    [2] �ź������ź�����΢�ָ��������о���Ӧ�ã������Զ������Ǳ�2013��40��04����474-477
    [3] ��᷷�, �ޱ�, ÷��. ����PD-ADRC����������������[J]. ��ؼ���, 2015, 34(12):62-65.
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