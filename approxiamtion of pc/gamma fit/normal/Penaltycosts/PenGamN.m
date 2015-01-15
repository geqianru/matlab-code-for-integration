function [Pen]= PenGamN(n)
 t = cputime;
 T = 10;
 for i = 1:n
       rs(i) = 1;
       mus(i) = 0.5;
       sigmas(i) = mus(i).*0.4;
       sems(i) = (T^2) * (rs(i)^2) * (mus(i)^2+sigmas(i)^2);
       ss(i) = mus(i) * T * rs(i);
       vs(i) = mus(i) * T * rs(i)^2;
 end
D_0 = sum ((mus-0.2).* rs).*T ;
c_p = 72000;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%first Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_1 = sum (ss);
%%%%%%%%%%%%%%%%%%%%%%%Second Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_21 = sum(sems);
M_22 = sum(ss)^2 - sum(ss.^2);
M_23 = sum(vs);
M_2 = M_21 + M_22 + M_23;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Scale parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
theta = M_2 / M_1 - M_1;
%display (theta);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shape parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = M_1 / theta;
%display (k);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CDF of Gamma distribution%%%%%%%%%%%%%%%%%%%%%
P_1=gamcdf(D_0,k+1,theta);
%display(P_1);
P_2=gamcdf(D_0,k,theta);
%display(P_2);
Pen=c_p.*theta.*k.*(1-P_1)-D_0.*c_p.*(1-P_2);
e = cputime-t;
display(e); 
display(Pen);
end
