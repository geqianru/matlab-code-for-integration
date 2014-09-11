function [Pene] = downexnor(n)
  t = cputime;
  T = 10;
    for i = 1:n
       mus(i) = 0.5;
       sigmas(i) = mus(i)*0.4; 
       rs(i) = 1;
       ss(i) = mus(i) * T * rs(i);
    end
  tdown = sum(ss);
  D_0 = sum ((mus-0.2).*rs).*T;
  c_p = 72000;
  Pene = max(0,tdown-D_0)*c_p;
  e = cputime-t;
end