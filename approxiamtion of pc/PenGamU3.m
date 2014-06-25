function [Pen, e]= PenGamU3(n)
%%%%%%%%%%%Use Gamma distribution to fit downtime distribution and lambda follow uniform distribution%%%%%%%%%%%%%%%%%
  t = cputime;
  T = 10;
  for i = 1:n
       a_i(i) = 0.25;
       b_i(i) = 0.75;
       r_i(i) = 1;
       mu_i(i) = 0.5 * (a_i(i) + b_i(i));
       sem_i(i) = (T^2) * (r_i(i)^2) * (a_i(i)^2 + a_i(i) * b_i(i) + b_i(i)^2)/3;
       s_i(i) = mu_i(i) * T * r_i(i);
       v_i(i) = mu_i(i) * T * r_i(i)^2;
    
  end
     



D_0 = sum (mu_i .* r_i).*T ;
c_p = 72000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%first Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_1 = sum (s_i);
%%%%%%%%%%%%%%%%%%%%%%%Second Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_21 = sum(sem_i);
M_22 = sum(s_i)^2 - sum(s_i.^2);
%M_22 = 2 * s_1 * s_2;
M_23 = sum(v_i);
M_2 = M_21 + M_22 + M_23;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Scale parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
theta = M_2 / M_1 - M_1;
display (theta);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shape parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = M_1 / theta;
display (k);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CDF of Gamma distribution%%%%%%%%%%%%%%%%%%%%%
P_1=gamcdf(D_0,k+1,theta);
display(P_1);
P_2=gamcdf(D_0,k,theta);
display(P_2);
Pen=c_p.*theta.*k.*(1-P_1)-D_0.*c_p.*(1-P_2);
e = cputime-t;
display(e); 
display(Pen);
end