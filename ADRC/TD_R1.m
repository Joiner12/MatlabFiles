%% 
% Created date : 2019��7��17��
clc;
disp('ADRC Block ')
PurposePath = 'D:\Codes\MatlabFiles\ADRC';
if ~strcmp(PurposePath,pwd)
    cd D:\Codes\MatlabFiles\ADRC
end
fprintf('load path...\n%s\n',pwd)
clear ans
%%
% ���Ժ���
%{
    ���˼·��
    1.΢��-������ �� ��ȡ΢���źţ�����ϵͳ���룻
    2.@parameter:h:���ֲ�����r�������ٿ�����
    3.΢�ָ�����ͬ��ͨ�˲�����KF���ܶԱȣ�
    4.��������˵����
        h �ǻ��ֲ�����r �Ǿ������ٿ����Ĳ�����r Խ��x1����� �����ź� v��
        ���� v ��������Ⱦʱ����ʹ�ź� x1��������� ������Ⱦ��
        Ϊ���˵� x1 ������������ѡȡ�ʵ��� h1���ܻ� �úܺõ��˲�Ч����Ȼ����
        h1 Խ�󣬾ͻ�ʹ x1 �����ź� v ����λ��ʧҲԽ�� 
    Reference:
    [1]�����壬����ǿ��TD�˲�������Ӧ��
    [2]�ź������ź�����΢�ָ��������о���Ӧ�ã������Զ������Ǳ�
        2013��40��04����474-477
%}
clc;
fprintf("΢��-����������\n");
t = zeros(0);
ts = 1e-3;              % ��������

% �����ź�
signal_fre = 10; % hz'
signal_amp = 1;

% �����ź� + �������
v = zeros(0);
diff_theroyvalue = zeros(0);
time = zeros(0);
x1 = zeros(0);
x2 = zeros(0);
lpx1 = zeros(0);
lpx2 = zeros(0);
v_dis = 0;

% ����ʱ��
simutime = 2;   % s
h1 = ts ; r = 1000;
for i = 1:1:simutime/ts
    v_cur = signal_amp*sin(2*pi*signal_fre*i*ts);
    if mod(i,20) == 0
        v_dis = (rand - 0.5)*signal_amp/10 ;
    end
    v_cur = v_cur + v_dis;
    time(i) = i*ts;
    v(i) = v_cur;
    if isequal(i,1)
        x1(i) = 0;
        x2(i) = 0;
        diff_temp = v_cur/ts;
    else
        [x1(i),x2(i)]  = TDR1(x1(i-1),x2(i-1),...
            v_cur,h1,r);
        diff_temp = (v(i) - v(i-1))/ts;
    end
    diff_theroyvalue(i) = diff_temp;
    
    % �ֲ�һ�׵�ͨ�˲�
    if isequal(i,1)
        lpx1(i) = 0;
        lpx2(i) = 0;
    else
        lp_cof = 0.4;
        lpx1(i) = v_cur*lp_cof + lpx1(i-1)*(1 - lp_cof);
        lpx2(i) = (lpx1(i) - lpx1(i-1))/ts;
    end
    
end
% figure
close all;
figure(1)
subplot(2,2,1)
plot(time,v,time,x1,time,x2,time,diff_theroyvalue)
legend('�����ź�','�����ź�','΢���ź�','���۲��ֵ')
set(get(gca, 'XLabel'), 'String', 't/m');
set(get(gca, 'YLabel'), 'String', 'height/mm');

subplot(2,2,2)
plot(time,lpx1,time,x1)
legend('��ͨ','΢�ָ�����x1')

subplot(2,2,3)
plot(time,lpx2,time,x2*80)
legend('��ͨ','΢�ָ�����x2')
%% ����ģ��
%{
    @param:
    {
        x1_k1 = x1(k+1);        (1) �����ź�
        x2_k1 = x2(k+1);        (2) ����΢���ź�
        x1_k = x1(k);           (3)
        x2_k = x2(k);           (4)
        v_k = v(k);             (5) ԭʼ�ź�
        y_k = y(k);             (6)
        h;                      (7) ���ֲ���
        r;                      (8) �ٶ�����
    }
    �漰��΢����ز�����ʼ����Ҫ�ں����ⲿ��ɣ�
    
%}
function [x1_k1,x2_k1] = TDR1(x1_k,x2_k,v_k,h1,r)
    d = h1*r;
    d1 = h1*d;
    % e(k) = x1(k) - v(k)                   (1)
    ek = x1_k - v_k;

    % y(k) = e(k) + h1*x2(k)                (2)
    y_k = ek + h1*x2_k;
    % g(k)                                  (3)
    gk_funout = gk_fun(x2_k,y_k,h1,r,d);

    %------------------fst(.)--------------------%
    fst_out = -r*SatV2(gk_funout,d);
    
    % 
    x1_k1 = x1_k + h1*x2_k;
    x2_k1 = x2_k + h1*fst_out;
end 

%------------------g(k)--------------------%
%{
    ������
    r                                   (1) �ٶ�����
    h1                                  (2) �˲�����   
    ��ʽ��
    d = h1*r                            (1) 
    d1 = h1*d                           (2)
    e(k) = x1(k) - v(k)                 (3)
    y(k) = e(k) + h1*x2(k)              (4)
%}
function y = gk_fun(x2_k,y_k,h1,r,d)
    d1 = h1*d;
    ret_temp = 0;
    if abs(y_k) >= d1
        ret_temp = x2_k + sign(y_k)*(sqrt(8*r*abs(y_k)+d^2) -d)/2;
    else
        ret_temp = x2_k + y_k/h1;
    end
    y = ret_temp;
end


%------------------sat(.)--------------------%
%{ 
    SISO���ͺ���
%}
function y = SatV1(x,delta,paraflag)
    if delta < 0
        delta = 0;
    end

    if paraflag
        fprintf("���ͺ���������:%d\n",delta);
    end

    if abs(x) >= delta
        y_temp = sign(x);
    else
        y_temp = x./delta;
    end
    y = y_temp;
end


%------------------sat(.)version2--------------------%
%{ 
    SISO���ͺ���
%}
function y = SatV2(x,delta)
    if delta < 0
        delta = 0;
    end

    if abs(x) >= delta
        y_temp = sign(x);
    else
        y_temp = x./delta;
    end
    y = y_temp;
end
