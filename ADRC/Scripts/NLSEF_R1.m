% part(i)
% µ¥µ÷º¯Êý for debug
function y = NLSEF_R1(u,alpha_1,delta_1,bt1,alpha_2,delta_2,bt2)
y = bt1*Fal_Func(u(1),alpha_1,delta_1) + bt2*Fal_Func(u(2),alpha_2,delta_2);
end
