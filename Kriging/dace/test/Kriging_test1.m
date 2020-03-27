% Kriging_test1
clear
load data1
theta=[10 10];
lob=[1e-1 1e-1];
upb=[10 10];
[dmodel, perf] = dacefit(S, Y, @regpoly2, @corrgauss, theta, lob, upb, 1);
X=gridsamp([0 0;100 100],40);
[YX MSE]=predictor(X,dmodel);
X1=reshape(X(:,1),40,40);
X2=reshape(X(:,2),40,40);
YX=reshape(YX,size(X1));
figure
mesh(X1,X2,YX)
hold on
plot3(S(:,1),S(:,2),Y,'.k','MarkerSize',10)
hold off
figure
mesh(X1,X2,reshape(MSE,size(X1)))
[y1 dy1]=predictor(S(1,:),dmodel);
[y2, dy2, mse, dmse]=predictor([50 50], dmodel);


