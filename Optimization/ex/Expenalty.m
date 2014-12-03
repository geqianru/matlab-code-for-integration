function [C_p] = Expenalty(r,mu,T,D_0,c_p)
%c_p = 1000;
Exdowntime = sum (mu .* r).*T;
C_p = c_p * max(Exdowntime-D_0,0);
end