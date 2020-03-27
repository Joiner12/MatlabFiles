function  [t, f, fit, itpar] = move(th, t, f, fit, itpar, par)
% Pattern move

nv = itpar.nv;   ne = itpar.ne;   p = length(t);
v = t ./ th;
if  all(v == 1)
  itpar.D = itpar.D([2:p 1]).^.2;
  return
end

% Proper move
rept = 1;
while  rept
  tt = min(itpar.up, max(itpar.lo, t .* v));  
  [ff  fitt] = objfunc(tt,par);  nv = nv+1;
  itpar.perf(:,nv) = [tt; ff; 3];
  if  ff < f
    t = tt;  f = ff;  fit = fitt;
    v = v .^ 2;
  else
    itpar.perf(end,nv) = -3;
    rept = 0;
  end
  if  any(tt == itpar.lo | tt == itpar.up), rept = 0; end
end

itpar.nv = nv;
itpar.D = itpar.D([2:p 1]).^.25;
