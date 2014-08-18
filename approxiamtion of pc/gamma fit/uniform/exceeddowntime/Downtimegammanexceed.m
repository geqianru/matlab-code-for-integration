 function [avg_a] = Downtimegammanexceed(n,sigma_f,ed_f)
T = 10;
mu50 = 1.6;
mu100 = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two normal distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
if (n==5)  
   for i = 1:n
        mus(i) = 1/(2*i);
        sigmas(i) = mus(i) * sigma_f;
        %display(sigmas(i));
        as(i) = mus(i) - sqrt(3) * sigmas(i);
        %display(as(i));
        bs(i) = mus(i) + sqrt(3) * sigmas(i);
        %display(bs(i));
        if (mod(i,3) == 1)
            rs(i) = 1;
        else
            if (mod(i,3) == 2)
                rs(i) = 3;
            else
                rs(i) = 5; 
            end
        end
        sems(i) = (T^2) * (rs(i)^2) * (as(i)^2 + as(i) * bs(i) + bs(i )^2)/3;
        ss(i) = mus(i) * T * rs(i);
        vs(i) = mus(i) * T * rs(i)^2;        
   end
else
    if (n==50)
           for i = 1:n
               mus(i) = 1./(mu50+1/6*(i-1));
               %display(mus(i));
               sigmas(i) = mus(i) * sigma_f;
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
               sems(i) = (T^2) * (rs(i)^2) * (as(i)^2 + as(i) * bs(i) + bs(i )^2)/3;
               ss(i) = mus(i) * T * rs(i);
               vs(i) = mus(i) * T * rs(i)^2;        
           end 
    else
        if (n==100)
            for i = 1:n
               mus(i) = 1./(mu100+1/11*(i-1));
               %display(mus(i));
               sigmas(i) = mus(i) * sigma_f;
               %display(sigmas(i));
               as(i) = mus(i) - sqrt(3) * sigmas(i);
               %display(as(i));
               bs(i) = mus(i) + sqrt(3) * sigmas(i);
               %display(bs(i));

               if (mod(i,3) == 1)
                   rs(i) = 1;
               else
                   if (mod(i,3) == 2)
                   rs(i) = 3;
                   else
                   rs(i) = 5; 
                   end
               end
               sems(i) = (T^2) * (rs(i)^2) * (as(i)^2 + as(i) * bs(i) + bs(i )^2)/3;
               ss(i) = mus(i) * T * rs(i);
               vs(i) = mus(i) * T * rs(i)^2;        
           end 
            
        else
             display('input argument error, n can only be 5,50,or 100');
        end
            
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%first Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_1 = sum(ss);
%%%%%%%%%%%%%%%%%%%%%%%Second Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_21 = sum(sems);
M_22 = M_1^2 - sum(ss.^2);
M_23 = sum(vs);
M_2 = M_21 + M_22 + M_23;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Scale parameter(B)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
theta = M_2 / M_1 - M_1;
display(theta);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shape parameter(A)%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = M_1 / theta;
display(k);
D_0 = sum (mus .* rs).*T * ed_f;
display(D_0);
%%%%%%%%%%get the expected exceeded downtime by using identities for the Gamma Distribution
avg_a = k.* theta .* (1-gamcdf(D_0,k+1,theta)) - D_0.* (1-gamcdf(D_0,k,theta));
display (avg_a);
end