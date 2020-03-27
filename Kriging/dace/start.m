function  [t, f, fit, itpar] = start(t0, lo, up, par)
% Get starting point and iteration parameters

% Initialize
t = t0(:);  lo = lo(:);   up = up(:);   p = length(t);
D = 2 .^ ([1:p]'/(p+2));
ee = find(up == lo);  % Equality constraints
if  ~isempty(ee)
  D(ee) = ones(length(ee),1);   t(ee) = up(ee); 
end
ng = find(t < lo | up < t);  % Free starting values
if  ~isempty(ng)
  t(ng) = (lo(ng) .* up(ng).^7).^(1/8);  % Starting point
end
ne = find(D ~= 1);

% Check starting point and initialize performance info
[f  fit] = objfunc(t,par);   nv = 1;
itpar = struct('D',D, 'ne',ne, 'lo',lo, 'up',up, ...
  'perf',zeros(p+2,200*p), 'nv',1);
itpar.perf(:,1) = [t; f; 1];
if  isinf(f)    % Bad parameter region
  return
end

if  length(ng) > 1  % Try to improve starting guess
  d0 = 16;  d1 = 2;   q = length(ng);
  th = t;   fh = f;   jdom = ng(1);  
  for  k = 1 : q
    j = ng(k);    fk = fh;  tk = th;
    DD = ones(p,1);  DD(ng) = repmat(1/d1,q,1);  DD(j) = 1/d0;
    alpha = min(log(lo(ng) ./ th(ng)) ./ log(DD(ng))) / 5;
    v = DD .^ alpha;   tk = th;
    for  rept = 1 : 4
      tt = tk .* v; 
      [ff  fitt] = objfunc(tt,par);  nv = nv+1;
      itpar.perf(:,nv) = [tt; ff; 1];
      if  ff <= fk 
        tk = tt;  fk = ff;
        if  ff <= f
          t = tt;  f = ff;  fit = fitt; jdom = j;
        end
      else
        itpar.perf(end,nv) = -1;   break
      end
    end
  end % improve
  
  % Update Delta  
  if  jdom > 1
    D([1 jdom]) = D([jdom 1]); 
    itpar.D = D;
  end
end % free variables

itpar.nv = nv;