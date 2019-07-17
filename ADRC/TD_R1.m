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
%{
    ���˼·��
    1.΢��-������ �� ��ȡ΢���źţ�����ϵͳ���룻
    2.@parameter:h:���ֲ�����r�������ٿ�����
    3.΢�ָ�����ͬ��ͨ�˲�����KF���ܶԱȣ�
    Reference:[1]�����壬����ǿ��TD�˲�������Ӧ��
%}

clc;
x = linspace(-10,10,100);
y = zeros(0);
for i=1:1:length(x)
    y(i)=Sat(x(i),5,true);
end

figure
line(x,y)

%------------------fst(.)--------------------%
function yf = fst(x,delta)
    yf = 0;
    
end


%------------------sat(.)--------------------%
% SISO���ͺ���
function y = Sat(x,delta,paraflag)
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

