function  [t, f, fit, itpar] = explore(t, f, fit, itpar, par)
% Explore step

nv = itpar.nv;   ne = itpar.ne;
for  k = 1 : length(ne)
  j = ne(k);   tt = t;   DD = itpar.D(j);
  if  t(j) == itpar.up(j)
    atbd = 1;   tt(j) = t(j) / sqrt(DD);
  elseif  t(j) == itpar.lo(j)
    atbd = 1;  tt(j) = t(j) * sqrt(DD);
  else
    atbd = 0;  tt(j) = min(itpar.up(j), t(j)*DD);
  end
  [ff  fitt] = objfunc(tt,par);  nv = nv+1;
  itpar.perf(:,nv) = [tt; ff; 2];
  if  ff < f
    t = tt;  f = ff;  fit = fitt;
  else
    itpar.perf(end,nv) = -2;
    if  ~atbd  % try decrease
      tt(j) = max(itpar.lo(j), t(j)/DD);
      [ff  fitt] = objfunc(tt,par);  nv = nv+1;
      itpar.perf(:,nv) = [tt; ff; 2];
      if  ff < f
        t = tt;  f = ff;  fit = fitt;
      else
        itpar.perf(end,nv) = -2;
      end
    end
  end
end % k

itpar.nv = nv;