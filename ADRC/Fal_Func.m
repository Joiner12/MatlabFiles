%{
    
%}
function y = Fal_Func(u,alpha,delta)
% �������
if (alpha <= 0 || alpha >=1)
    error('@Fal_Func ���� �� alpha ����');
end

if delta <= 0
    error('@Fal_Func ���� ��delta ����');
end

temp = 0;
if abs(u) <= delta
    temp = u/power(delta,1-alpha);
else
    temp = power(abs(u),alpha)*sign(u);
end
y = temp;