%% SIGMOID DT(differential tracker)
%{
    sig(x) = 1/(1+exp(-x))
    1.fst函数改进为sigmoid,稳定点附近线性光滑,远离点附近非线性;
    2.Continuous formula：
    x1'(t) = x2(t)
    x2'(t) = -R^2(sig(x1(t)-v(t)) + sig(x2(t)/R))
    3.Discrete formula:
    x1(k+1) = x1(k) + h*x2(k)
    x2(k+1) = x2(k) + h*[-R^2*(sig(x1(k) - v(k)) + sig(x2(k)/R))]

    reference:
    [1] H:\MatlabFiles\ADRC\Scripts\Nl_Sigmoid.m
    [2] 《基于改进sigmoid函数的非线性跟踪微分器》邵星灵，王宏伦
    [3] 《新型离散跟踪-微分器的设计与分析》
%}
% simulation block
%
% a*[(1+exp(-bx))^-1 - 0.5] anomynous sigmoid function
sig = @(x,a,b) a*(((1+exp(-b*x))^-1)- 0.5);

ts = 1E-3;
x = zeros(1,2);  % 系统状态
X_DT = zeros(0); % 跟踪输出
OperatCnt = 1;
tick = zeros(0); % 仿真时间
% SingalGenerator
% file : H:\MatlabFiles\ADRC\Scripts\SingalGenerator.m
vt =  zeros(0);
vt_n = zeros(0);
[vt,vt_n] = SignalGenerator(false,1);
vt_n = vt;
vt_n = vt_n;
r = 10000;
while OperatCnt < length(vt_n)
    % initialization
    if isequal(OperatCnt,1)
        x(1) = vt_n(1);
        x(2) = 0;
        OperatCnt = OperatCnt + 1;
    else
        % 
        tempValue = -r*r*(sig(x(1) - vt_n(OperatCnt),0.5,20) + sig(x(2)/r,0.5,20));
        x(1) = x(1) + ts*x(2);
        x(2) = x(2) + ts*tempValue;
        X_DT(:,OperatCnt) = x';
        OperatCnt = OperatCnt + 1;
        tick(OperatCnt) = OperatCnt;
    end
end


figure
subplot(211)
plot(1:1:length(X_DT(1,:)),vt_n(1:length(X_DT(1,:))))
hold on
plot(1:1:length(X_DT(1,:)),X_DT(1,:))
hold on
plot(1:1:length(X_DT(1,:)),vt_n(1:length(X_DT(1,:))) - X_DT(1,:))
legend('origin','track','error')

subplot(212)

plot(1:1:length(X_DT(2,:)),X_DT(2,:))