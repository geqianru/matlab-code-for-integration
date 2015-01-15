function [Pene] = downex(n)
  t = cputime;
  T = 10;
    for i = 1:n
       as(i) = 0.25;
       bs(i) = 0.75;
       rs(i) = 1;
       mus(i) = 0.5 * (as(i) + bs(i));
       ss(i) = mus(i) * T * rs(i);
    end
  tdown = sum(ss);
  D_0 = sum ((mus-0.1).*rs).*T;
  c_p = 72000;
  Pene = max(0,tdown-D_0)*c_p;
  e = cputime-t;
end