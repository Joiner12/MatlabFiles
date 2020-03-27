% Kriging_test2
clear
% 函数的准确值图形
X=gridsamp([0 0;3.5 3.5],100);
X1=reshape(X(:,1),100,100);
X2=reshape(X(:,2),100,100);
Y_real=Kriging_fun1(X);
Y_real=reshape(Y_real,size(X1));
figure
mesh(X1,X2,Y_real)
axis square
% axis([0 3.5 0 3.5 0 12])

% Kriging预测值图形
option.fun=1;
option.criterion='maximin';
option.iterations=1000;
S = lhsamp(50,2,{'uniform',0,3.5;'uniform',0,3.5},option);
Y=Kriging_fun1(S);
theta=[10 10];
lob=[1e-1 1e-1];
upb=[10 10];
[dmodel1, perf1] = dacefit(S, Y, @regpoly2, @corrgauss, theta, lob, upb, 1);
% X=gridsamp([0 0;3.5 3.5],100);
% X1=reshape(X(:,1),100,100);
% X2=reshape(X(:,2),100,100);
[YX MSE1]=predictor(X,dmodel1);
YX=reshape(YX,size(X1));

figure
mesh(X1,X2,YX)
hold on
plot3(S(:,1),S(:,2),Y,'.k','MarkerSize',10)
axis square
axis([0 3.5 0 3.5 0 12])
hold off

figure
mesh(X1,X2,reshape(sqrt(MSE1),size(X1)))

Y_err21=(Y_real-YX).^2;
figure
mesh(X1,X2,sqrt(Y_err21))
axis square

average_Y_err1=sum(sum(sqrt(Y_err21)))./size(X1,1).^2;
max_Y_err1=max(max(sqrt(Y_err21)./YX));















[dmodel2, perf2] = dacefit(S, Y, @regpoly2, @corrgauss, theta, lob, upb, 10);
[YX2 MSE]=predictor(X,dmodel2);
YX2=reshape(YX2,size(X1));
figure
mesh(X1,X2,YX2)
hold on
plot3(S(:,1),S(:,2),Y,'.k','MarkerSize',10)
axis square
axis([0 3.5 0 3.5 0 12])
hold off
figure
mesh(X1,X2,reshape(sqrt(MSE),size(X1)))

Y_err22=(Y_real-YX2).^2;
figure
mesh(X1,X2,sqrt(Y_err22))
axis square

average_Y_err2=sum(sum(sqrt(Y_err22)))./size(X1,1).^2;
max_Y_err2=max(max(sqrt(Y_err22)./YX2));










