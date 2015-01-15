function [pavg_a] = mixerlanguniformn(n,sigma_f,ed_f)
T = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two uniformly distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
if (n==5)
   for i = 1:n
       mus(i) = 1/(2*i);
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
       sems(i) = (T^2) * (rs(i)^2) * (as(i)^2 + as(i) * bs(i) + bs(i)^2)/3;
       ss(i) = mus(i) * T * rs(i);
       v1(i) = sigmas(i)^2 * T^2 * rs(i)^2;
       v2(i) = mus(i) * T * rs(i)^2;
       %v3(i) = mus(i)^2 * T^2 * rs(i)^2;     
   end
else
    if (n==50)
        for i = 1:n
            mus(i) = 1/(1 + (1/5.5)*(i-1));
            sigmas(i) = mus(i)* sigma_f;
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
            sems(i) = (T^2) * (rs(i)^2) * (as(i)^2 + as(i) * bs(i) + bs(i)^2);
            ss(i) = mus(i) * T * rs(i);
            v1(i) = sigmas(i)^2 * T^2 * rs(i)^2;
            v2(i) = mus(i) * T * rs(i)^2;
            %v3(i) = mus(i)^2 * T^2 * rs(i)^2;    
        end
    else
        if (n==100)
            for i = 1:n
                mus(i) = 1/(1 + 1/11*(i-1));
                sigmas(i) = mus(i)* sigma_f;
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
                sems(i) = (T^2) * (rs(i)^2) * (mus(i)^2+sigmas(i)^2);
                ss(i) = mus(i) * T * rs(i);
                v1(i) = sigmas(i)^2 * T^2 * rs(i)^2;
                v2(i) = mus(i) * T * rs(i)^2;
                %v3(i) = mus(i)^2 * T^2 * rs(i)^2;              
            end
        else
            display('input argument error, n can only be 5,50,or 100')
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%Mean of downtime%%%%%%%%%%%%%%%%%%%%%%%
 M_1 = sum (ss);
% %%%%%%%%%%%%%%%%%%%%%%%Variance of downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Variance = sum(v1) + sum(v2);
%%%%%%%Coefficent of variation
 c_v = sqrt(Variance)/(M_1);
%%%%%%%%%%%%%%%%%%%estimate parameter k,q,theta in the erlang distribution
k = ceil(1/c_v^2);
q = 1/(1 + c_v^2) .* (k .* c_v^2 - sqrt( k .* (1 + c_v^2) - k^2 .* c_v^2));
theta = (k - q)/(M_1);
%%%%%%%%%%%%%D_0(targeted downtime)%%%%%%%%%%%%%%%
D_0 = sum (mus .* rs).*T * ed_f;
%%%%%%%%%%%%%%%%%%%average exceeded downtime%%%%%%%%%%%%%%%%%%%%%%%%%
avg_a1 = D_0*(1-(q * gamcdf(D_0,k-1,1./theta)+(1-q)*gamcdf(D_0,k,1./theta)));
avg_a = q * (k-1) / theta * (1 - gamcdf(D_0,k,1./theta)) + k * (1-q) / theta * (1-gamcdf(D_0,k+1,1./theta))-avg_a1;
pavg_a = avg_a/D_0;           
end