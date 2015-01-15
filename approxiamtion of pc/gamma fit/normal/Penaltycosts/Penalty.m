function [Pen]= Penalty(mu_1,mu_2,r_1,r_2)
t = cputime; 
T = 10;
D_0 = (mu_1+mu_2)*T;
c_p = 72000;
sigma_1 = mu_1 * 0.4;
sigma_2 = mu_2 * 0.4;
s_1=mu_1.*T.*r_1;
s_2=mu_2.*T.*r_2;
v_1=mu_1 * T * r_1^2;
v_2=mu_2 * T * r_2^2;
%display(sum(s_1+s_2));
sem_1 = (mu_1^2 + sigma_1^2) * (r_1^2) * (T^2);
sem_2 = (mu_2^2 + sigma_2^2) * (r_2^2) * (T^2);
%%%%%first Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_1 = s_1 + s_2;
%%%%%%%%%%%%%%%%%%%%%%%Second Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_21 = sem_1 + sem_2;
M_22 = 2 * s_1 * s_2;
M_23 = v_1 + v_2;
M_2 = M_21 + M_22 + M_23;
%s_3=Lambda_3.*T.*r_3;
%v_3=Lambda_3.*T.*r_3^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Scale parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
theta = M_2 / M_1 - M_1;
display(theta);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shape parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = M_1 / theta;
display(k);
% pd1 = makedist('Gamma','a',k,'b',theta);
% m_1=mean(pd1);
% display(m);
% pd2 = makedist('Gamma','a',k+1,'b',theta);
% m_2=mean(pd2); 
% x = gamrnd(k,theta);
% m_1=mean(x(x>D_0));
% m_2=mean(x);
% display(m_1);
% display(m_2);
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