function [Pen, e]= PenGamU3(D_0)
%%%%%%%%%%%Use Gamma distribution to fit downtime distribution and lambda follow uniform distribution%%%%%%%%%%%%%%%%%
  t = cputime;
  T = 10;
  n = 3;
  for i = 1:n
      if i<=1
        as(i) = 0.25;
        bs(i) = 0.75;
        rs(i) = 2.5;
      elseif (i<=2)&&(i>1)
        as(i) = 0.15;
        bs(i) = 0.65;
        rs(i) = 2;
      elseif (i<=3)&&(i>2)
        as(i) = 0.10;
        bs(i) = 0.60;
        rs(i) = 1.5;
      elseif (i>60)&&(i<=80)
        as(i) = 0.15;
        bs(i) = 0.45;
        rs(i) = 1;
      else (i>80)&&(i<=100)
        as(i) = 0.10;
        bs(i) = 0.40;
        rs(i) = 1;
      end 
       mus(i) = 0.5 * (as(i) + bs(i));
       sems(i) = (T^2) * (rs(i)^2) * (as(i)^2 + as(i) * bs(i) + bs(i)^2)/3;
       ss(i) = mus(i) * T * rs(i);
       vs(i) = mus(i) * T * rs(i)^2;  
  end
%D_0 = sum (mus.*rs).*T ;
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