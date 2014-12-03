function [avgstochnumpenaltycost] = stochnumpenalty(r,mu,T,D_0,c_p)
%c_p = 1000;
sample = 1000;
%D_0 = sum(mu.* T .* r);
  for i = 1 : length(mu)
      p(i) = mu(i) .* T;
      downtimec(i,:) = poissrnd(p(i),[1, sample])* r(i);
  end
totaldowntime = sum(downtimec);
exdowntime = max(totaldowntime - D_0, 0);
stochnumpenaltycost = c_p .* exdowntime;
avgstochnumpenaltycost = mean(stochnumpenaltycost);
end
