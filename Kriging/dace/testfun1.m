function Y=testfun1(S)
% 算例9.1 g(x)=exp(0.2*x1+1.4)-x2
% testfun1

[m n]=size(S); % m:number of design sites. n:number of number of variables
if n~=2
    disp('g(x)=exp(0.2*x1+1.4)-x2有两个变量');
end

Y=exp(0.2*S(:,1)+1.4)-S(:,2);











