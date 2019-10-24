%{
    
%}
function y = Fal_Func(u,alpha,delta)
% 参数检查
if (alpha <= 0 || alpha >=1)
    error('@Fal_Func 参数 ： alpha 错误');
end

if delta <= 0
    error('@Fal_Func 参数 ：delta 错误');
end

temp = 0;
if abs(u) <= delta
    temp = u/power(delta,1-alpha);
else
    temp = power(abs(u),alpha)*sign(u);
end
y = temp;