function [Pen]= PenGamU(a_1,b_1,a_2,b_2,r_1,r_2)
%%%%%%%%%%%Use Gamma distribution to fit downtime distribution and lambda follow uniform distribution%%%%%%%%%%%%%%%%%
t = cputime; 
T = 10;
mu_1 = 0.5 * (a_1 + b_1);
mu_2 = 0.5 * (a_2 + b_2);
sem_1 = (T^2) * (r_1^2) * (a_1^2 + a_1 * b_1 + b_1^2)/3;
sem_2 = (T^2) * (r_2^2) * (a_2^2 + a_2 * b_2 + b_2^2)/3;
D_0 = (mu_1 * r_1 + mu_2 * r_2) * T;
c_p = 72000;
s_1 = mu_1 * T * r_1;
s_2 = mu_2 * T * r_2;
v_1 = mu_1 * T * r_1^2;
v_2 = mu_2 * T * r_2^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%first Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_1 = s_1 + s_2;
%%%%%%%%%%%%%%%%%%%%%%%Second Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_21 = sem_1 + sem_2;
M_22 = 2 * s_1 * s_2;
M_23 = v_1 + v_2;
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
%display(Pen);
end