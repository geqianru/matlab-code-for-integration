function [Pen]= PenGamU3(b_1)
%%%%%%%%%%%Use Gamma distribution to fit downtime distribution and lambda follow uniform distribution%%%%%%%%%%%%%%%%%
  t = cputime;
  T = 10;
        as(1) = 0.20;
%         b_1 = 0.75;
        r_1 = 2.5;
        as(2) = 0.15;
        bs(2) = 0.65;
        r_2 = 2;
        as(3) = 0.10;
        bs(3) = 0.60;
        r_3 = 1.5;
       mus(1) = 0.5 * (as(1) + b_1);
       mus(2) = 0.5 * (as(2) + bs(2));
       mus(3) = 0.5 * (as(3) + bs(3));
       sems(1) = (T^2) * (r_1^2) * (as(1)^2 + as(1) * b_1 + b_1^2)/3;
       sems(2) = (T^2) * (r_2^2) * (as(2)^2 + as(2) * bs(2) + bs(2)^2)/3;
       sems(3) = (T^2) * (r_3^2) * (as(3)^2 + as(3) * bs(3) + bs(3)^2)/3;
       ss(1) = mus(1) * T * r_1;
       ss(2) = mus(2) * T * r_2;
       ss(3) = mus(3) * T * r_3;
       vs(1) = mus(1) * T * r_1^2;
       vs(2) = mus(2) * T * r_2^2;
       vs(3) = mus(3) * T * r_3^2;
D_0 = sum (mus(1)*r_1 + mus(2)*r_2 + mus(3)*r_3).*T ;
c_p = 72000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%first Moment of downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_1 = sum (ss);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Second Moment of downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_21 = sum(sems);
M_22 = sum(ss)^2 - sum(ss.^2);
%M_22 = 2 * s_1 * s_2;
M_23 = sum(vs);
M_2 = M_21 + M_22 + M_23;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Scale parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
theta = M_2 / M_1 - M_1;
%display (theta);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shape parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = M_1 / theta;
%display (k);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CDF of Gamma distribution%%%%%%%%%%%%%%%%%%%%%
P_1 = gamcdf(D_0,k+1,theta);
%display(P_1);
P_2 = gamcdf(D_0,k,theta);
%display(P_2);
Pen = c_p.*theta.*k.*(1-P_1)-D_0.*c_p.*(1-P_2);
e = cputime-t;
display(e); 
display(Pen);
end