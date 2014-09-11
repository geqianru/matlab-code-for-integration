function [downtime] = Gammalognormaln(n,sigma_f)
T = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two uniformly distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
if (n==5)
   for i = 1:n
       mus(i) = 1/(2*i);
       sigmas(i) = mus(i) * sigma_f;
       sigmaln(i) = sqrt(log(sigmas(i)^2/mus(i)^2 + 1));
       muln(i) = log(mus(i)) - 0.5 * sigmaln(i)^2;
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
       vs(i) = mus(i) * T * rs(i)^2;     
   end
else
    if (n==50)
        for i = 1:n
            mus(i) = 1/(1 + (1/5.5)*(i-1));
            sigmas(i) = mus(i)* sigma_f;
            sigmaln(i) = sqrt(log(sigmas(i)^2/mus(i)^2 + 1));
            muln(i) = log(mus(i)) - 0.5 * sigmaln(i)^2;
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
            vs(i) = mus(i) * T * rs(i)^2; 
        end
    else
        if (n==100)
            for i = 1:n
                mus(i) = 1/(1 + 1/11*(i-1));
                sigmas(i) = mus(i)* sigma_f;
                sigmaln(i) = sqrt(log(sigmas(i)^2/mus(i)^2 + 1));
                muln(i) = log(mus(i)) - 0.5 * sigmaln(i)^2;
                lambdas(i) = lognrnd(muln(i), sigmaln(i));
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
                vs(i) = mus(i) * T * rs(i)^2; 
            end
        else
            display('input argument error, n can only be 5,50,or 100')
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%First Moment of downtime%%%%%%%%%%%%%%%%%%%%%%%
M_1 = sum (ss);
%%%%%%%%%%%%%%%%%%%%%%%Second Moment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_21 = sum(sems);
M_22 = sum(ss)^2 - sum(ss.^2);
M_23 = sum(vs);
M_2 = M_21 + M_22 + M_23;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Scale parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
theta = M_2 / M_1 - M_1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CDF of Gamma distribution%%%%%%%%%%%%%%%%%%%%%
k = M_1 / theta;
x_1 = gaminv((0.005:0.01:1),k,theta);
y_1 = gampdf(x_1,k,theta);
plot(x_1,y_1,'Color','r','LineStyle',':','LineWidth',2);
end