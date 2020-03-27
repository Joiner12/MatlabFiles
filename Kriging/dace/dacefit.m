function  [dmodel, perf] = dacefit(S, Y, regr, corr, theta0, lob, upb, method)
%DACEFIT Constrained non-linear least-squares fit of a given correlation
% model to the provided data set and regression model
%
% Call
%   [dmodel, perf] = dacefit(S, Y, regr, corr, theta0)
%   [dmodel, perf] = dacefit(S, Y, regr, corr, theta0, lob, upb)
%
% Input
% S, Y    : Data points (S(i,:), Y(i,:)), i = 1,...,m
% regr    : Function handle to a regression model
% corr    : Function handle to a correlation function
% theta0  : Initial guess on theta, the correlation function parameters
% lob,upb : If present, then lower and upper bounds on theta
%           Otherwise, theta0 is used for theta
% method  : 优化theta的算法选择,1表示ga,2表示sa,3表示粒子群，4表示drect,5表示序列二次规划，6表示boxmin；
%
% Output
% dmodel  : DACE model: a struct with the elements
%    regr   : function handle to the regression model
%    corr   : function handle to the correlation function
%    theta  : correlation function parameters,也叫各项异性参数，通过优化得到
%    beta   : generalized least squares estimate
%    gamma  : correlation factors
%    sigma2 : maximum likelihood estimate of the process variance
%    S      : scaled design sites
%    Ssc    : scaling factors for design arguments,[mS; sS]
%    Ysc    : scaling factors for design ordinates,[mY; sY]
%    C      : Cholesky factor of correlation matrix，对correlation
%             matrix进行Cholesky分解得到，为上三角阵
%    Ft     : Decorrelated regression matrix
%    G      : From QR factorization: Ft = Q*G' .
% perf    : struct with performance information. Elements
%    nv     : Number of evaluations of objective function
%    perf   : (q+2)*nv array, where q is the number of elements 
%             in theta, and the columns hold current values of
%                 [theta;  psi(theta);  type]
%             |type| = 1, 2 or 3, indicate 'start', 'explore' or 'move'
%             A negative value for type indicates an uphill step

% hbn@imm.dtu.dk  
% Last update September 3, 2002

% S Design sites: an m*n array with S(i; :),设计点为n维，共m组
% Y m*q array with responses at S,响应维数为q维，共m组


% Check design points
% 检查设计点和响应是否都有m组
[m n] = size(S);  % number of design sites and their dimension
sY = size(Y);
if  min(sY) == 1
    Y = Y(:);   % 将响应转化为列向量
    lY = max(sY); % lY为响应的组数m
    sY = size(Y);
else
    lY = sY(1);
end
if m ~= lY
  error('S and Y must have the same number of rows')
end

% Check correlation parameters
lth = length(theta0);
if  nargin > 5  % optimization case
  if  length(lob) ~= lth || length(upb) ~= lth
    error('theta0, lob and upb must have the same length'), end
  if  any(lob <= 0) || any(upb < lob)
    error('The bounds must satisfy  0 < lob <= upb'), end
else  % given theta
  if  any(theta0 <= 0)
    error('theta0 must be strictly positive'), end
end

% Normalize data
mS = mean(S);   sS = std(S);
mY = mean(Y);   sY = std(Y);
% 02.08.27: Check for 'missing dimension'
j = find(sS == 0);
if  ~isempty(j)
    sS(j) = 1;
end
j = find(sY == 0);
if  ~isempty(j)
    sY(j) = 1;
end
S = (S - repmat(mS,m,1)) ./ repmat(sS,m,1);
Y = (Y - repmat(mY,m,1)) ./ repmat(sY,m,1);

% Calculate distances D between points，距离为normalize后的距离
mzmax = m*(m-1) / 2;        % number of non-zero distances
ij = zeros(mzmax, 2);       % initialize matrix with indices
D = zeros(mzmax, n);        % initialize matrix with distances
ll = 0;
for k = 1 : m-1
  ll = ll(end) + (1 : m-k);
  ij(ll,1)=k*ones(m-k,1); % indices for sparse matrix
  ij(ll,2)=(k+1:m)';
  D(ll,:) = repmat(S(k,:), m-k, 1) - S(k+1:m,:); % differences between points
end
% 检查有没有相同的设计点
if  min(sum(abs(D),2) ) == 0
  error('Multiple design sites are not allowed')
end

% Regression matrix
F = feval(regr, S); % 维数为m*p,p为回归模型基函数的个数
[mF p] = size(F);
if  mF ~= m
    error('number of rows in  F  and  S  do not match')
end
if  p > mF
    error('least squares problem is underdetermined')
end

% parameters for objective function
par = struct('corr',corr, 'regr',regr, 'y',Y, 'F',F, ...
  'D', D, 'ij',ij, 'scS',sS);

% Determine theta
if  nargin > 5
  % Bound constrained non-linear optimization
  % f是优化相关系数时，需要最小化的函数，f=sigma.^2*detR
  if nargin==7
      method=1; % 若未指定，默认使用遗传算法
  end
  if method==1
      [theta f fit perf] = gamin(lob, upb, par);
  elseif method==2
      [theta f fit perf] = samin(theta0, lob, upb, par);
  elseif method==3||method==3.1
      [theta f fit perf] = pso1min(lob, upb, par);
  elseif method==3.2
      [theta f fit perf] = pso2min(theta0, lob, upb, par);
  elseif method==4
      [theta f fit perf] =directmin(lob, upb, par);
  elseif method==5
      [theta f fit perf] =sqpmin(theta0, lob, upb, par);
  else
      [theta f fit perf] = boxmin(theta0, lob, upb, par);
  end
  %fid=fopen('f.txt','a+');
  %fprintf(fid,'%.4f\n',f);
  %fclose(fid);
  if  isinf(f)
    error('Bad parameter region.  Try increasing  upb'), end
else
  % Given theta
  theta = theta0(:);   
  [f  fit] = objfunc(theta, par);
  perf = struct('perf',[theta; f; 1], 'nv',1);
  if  isinf(f)
    error('Bad point.  Try increasing theta0'), end
end

% Return values
dmodel = struct('regr',regr, 'corr',corr, 'theta',theta.', ...
  'beta',fit.beta, 'gamma',fit.gamma, 'sigma2',sY.^2.*fit.sigma2, ...
  'S',S, 'Ssc',[mS; sS], 'Ysc',[mY; sY], ...
  'C',fit.C, 'Ft',fit.Ft, 'G',fit.G);

% >>>>>>>>>>>>>>>>   Auxiliary functions  ====================

% function  [obj, fit] = objfunc(theta, par)

% --------------------------------------------------------

% function  [t, f, fit, perf] = boxmin(t0, lo, up, par)

% --------------------------------------------------------

% function  [t, f, fit, itpar] = start(t0, lo, up, par)
% Get starting point and iteration parameters

% --------------------------------------------------------

% function  [t, f, fit, itpar] = explore(t, f, fit, itpar, par)
% Explore step

% --------------------------------------------------------

% function  [t, f, fit, itpar] = move(th, t, f, fit, itpar, par)
% Pattern move
