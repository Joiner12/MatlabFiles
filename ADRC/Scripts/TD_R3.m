%% path
clc;clear;
if ~strcmp(pwd,'H:\MatlabFiles\ADRC\Scripts')
    cd('H:\MatlabFiles\ADRC\Scripts');
end
fprintf('Road path...%s\t\n%s\n',pwd,'ADRC');
clear ans
%% ˫�����к���
%{
    tanh(x) = (exp(x) - exp(-x))/(exp(x) + exp(-x))
    sigmoid(x) = (1+exp(-x))^-1
    ��ͬ�����Ա�
    f(x1,x2,R,h,n) = x2 + s*sqrt(n^2*h^2*r^2 + |Ry|) - s
%}
t = linspace(0,10,100);
y1 = exp(t.*t*(-1));
figure 
plot(t,y1)
grid minor 


%% 
%{
    ����Ϊ1�Ķ������ſ����ۺϺ���
%}
clc;
fprintf('anonymous function of fast control...\n');
% fst_1 = @(x1,x2,r) -r.*sin(x1 + x2.*abs(x2)/2/r) + r*cos(10*(x1 + x2.*abs(x2)/2/r));
fst_1 = @(x1,x2,r) -r.*exp(sin(x1 + x2.*abs(x2)/2/r)) + r*cos(10*(x1 + x2.*abs(x2)/2/r));
[x1,x2] = meshgrid(-1:0.1:1);
y = fst_1(x1,x2,5); 
figure
subplot(211)
surf(x1,x2,y)
subplot(212)
mesh(x1,x2,y)



