%% 
% Created date : 2019��7��17��
clc;
disp('ADRC Block ')
PurposePath = 'D:\Codes\MatlabFiles\ADRC';
if ~strcmp(PurposePath,pwd)
    cd D:\Codes\MatlabFiles\ADRC
end
fprintf('load path\t>>>>\t%s\n',pwd)
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
    Reference:[1]�����壬����ǿ��TD�˲�������Ӧ��
%}

fprintf("΢��-����������\n");
clc;
% clear;
t = linspace(0,199,200); % s
signal_fre = 10; % hz'
sample_fre = 0.01; %hz'
v = 10*sin(2*pi*signal_fre.*t) + (rand(1,200).*2 - 1);
OptCnt = 0;
x1 = zeros(200,1);
x2 = zeros(200,1);
diff_theroyvalue = 10*cos(2*pi*signal_fre.*t);
h1 = 0.1 ; r = 400;
while OptCnt < length(t)
    OptCnt = OptCnt + 1;
    if OptCnt > 1
        [x1(OptCnt),x2(OptCnt)]  = TDR1(x1(OptCnt-1),x2(OptCnt-1),...
        v(OptCnt - 1),h1,r);
    end
end

% figure
close all;
figure(1)
plot(v)
hold on 
plot(x1)
hold on 
plot(x2)
hold on 
plot(diff_theroyvalue)
legend('ԭʼ','�����ź�','΢���ź�','����΢��ֵ')

%% ����ģ��
%{
    @param:{
        x1_k1 = x1(k+1);        (1)
        x2_k1 = x2(k+1);        (2)
        x1_k = x1(k);           (3)
        x2_k = x2(k);           (4)
        v_k = v(k);             (5)
        y_k = y(k);             (6)
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
