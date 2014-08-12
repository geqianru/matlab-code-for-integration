 function [dt] = Downtimegamman(n)
T = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two normal distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
  for i = 1:n
        mus(i) = 1/(2*i);
        sigmas(i) = mus(i)*0.2;
        as(i) = mus(i) - sqrt(3) * sigmas(i);
        bs(i) = mus(i) + sqrt(3) * sigmas(i);
        if (mod(i,3) == 1)
            rs(i) = 1;
        else
            if (mod(i,3) == 2)
                rs(i) = 3;
            else
                rs(i) = 5; 
            end
        end
        sems(i) = (T^2) * (rs(i)^2) * (as(i)^2 + as(i) * bs(i) + bs(i)^2)/3;
        ss(i) = mus(i) * T * rs(i);
        vs(i) = mus(i) * T * rs(i)^2;        
  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%first Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_1 = sum(ss);
%%%%%%%%%%%%%%%%%%%%%%%Second Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_21 = sum(sems);
M_22 = M_1^2 - sum(ss.^2);
M_23 = sum(vs);
M_2 = M_21 + M_22 + M_23;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Scale parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
theta = M_2 / M_1 - M_1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shape parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = M_1 / theta;
x_1 = gaminv((0.005:0.01:0.995),k,theta);
y_1 = gampdf(x_1,k,theta);
plot(x_1,y_1,'r');

end