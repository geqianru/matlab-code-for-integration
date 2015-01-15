function [k,theta,q] = plotmixerlanglognormalnparameter(n,sigma_f)
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
       v1(i) = sigmas(i)^2 * T^2 * rs(i)^2;
       v2(i) = mus(i) * T * rs(i)^2;
       %v3(i) = mus(i)^2 * T^2 * rs(i)^2;     
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
            v1(i) = sigmas(i)^2 * T^2 * rs(i)^2;
            v2(i) = mus(i) * T * rs(i)^2;
            %v3(i) = mus(i)^2 * T^2 * rs(i)^2;    
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
display(k);
q = 1/(1 + c_v^2) .* (k .* c_v^2 - sqrt( k .* (1 + c_v^2) - k^2 .* c_v^2));
display(q);
theta = (k - q)/(M_1);
a = 1/theta;
display(a);
x_1 = gaminv((0.001:0.01:1),k,1./theta);
y_1 = gampdf(x_1,k,1./theta);
plot(x_1,y_1,'Color','r','LineStyle',':','LineWidth',2);
end
