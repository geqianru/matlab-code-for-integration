function [dt] = Downtime(a_1,b_1,r_1,a_2,b_2,r_2)
%t = cputime;
T = 10;
%%%%%%%%%%%%%%%%%%%%%%Basic parts of first and second momoents of downtime%
mu_1 = 0.5 * (a_1 + b_1);
mu_2 = 0.5 * (a_2 + b_2);
sem_1 = (T^2) * (r_1^2) * (a_1^2 + a_1 * b_1 + b_1^2)/3;
sem_2 = (T^2) * (r_2^2) * (a_2^2 + a_2 * b_2 + b_2^2)/3;
%D_0 = (mu_1 * r_1 + mu_2 * r_2) * T;
%c_p = 72000;
s_1 = mu_1 * T * r_1;
s_2 = mu_2 * T * r_2;
v_1 = mu_1 * T * r_1^2;
v_2 = mu_2 * T * r_2^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%first Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_1 = s_1 + s_2;
%%%%%%%%%%%%%%%%%%%%%%%Second Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_21 = sem_1 + sem_2;
M_22 = M_1^2 - (s_1^2 + s_2^2);
M_23 = v_1 + v_2;
M_2 = M_21 + M_22 + M_23;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Scale parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
theta = M_2 / M_1 - M_1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shape parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = M_1 / theta;
x_1 = gaminv((0.005:0.01:0.995),k,theta);
y_1 = gampdf(x_1,k,theta);

plot(x_1,y_1,'r');
% display(e); 
% display(dt);

end