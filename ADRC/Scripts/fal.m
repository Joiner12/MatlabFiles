function y = fal(epec,alpha,delta)
if abs(epec) > delta
    y = abs(epec).^alpha.*sign(epec);
else
    y = epec./(delta^(1 - alpha));
end