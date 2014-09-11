function [downtime] = MSlognormaln(n,sigma_f)
T = 10;
samples = 10000;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two uniformly distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
if (n==5)
   for i = 1:n
       mus(i) = 1/(2*i);
       sigmas(i) = mus(i) * sigma_f;
       sigmaln(i) = sqrt(log(sigmas(i)^2/mus(i)^2 + 1));
       muln(i) = log(mus(i)) - 0.5 * sigmaln(i)^2;
       lambdas(i,:) = lognrnd(muln(i), sigmaln(i),samples,1);
       if (mod(i,3) == 1)
            rs(i) = 1;
        else
            if (mod(i,3) == 2)
                rs(i) = 3;
            else
                rs(i) = 5; 
            end
        end
   end
else
    if (n==50)
        for i = 1:n
            mus(i) = 1/(1 + (1/5.5)*(i-1));
            sigmas(i) = mus(i)* sigma_f;
            sigmaln(i) = sqrt(log(sigmas(i)^2/mus(i)^2 + 1));
            muln(i) = log(mus(i)) - 0.5 * sigmaln(i)^2;
            lambdas(i,:) = lognrnd(muln(i), sigmaln(i),samples,1);
            if (mod(i,3) == 1)
                rs(i) = 1;
            else
                if (mod(i,3) == 2)
                    rs(i) = 3;
                else
                    rs(i) = 5;
                end
            end
        end
    else
        if (n==100)
            for i = 1:n
                mus(i) = 1/(1 + 1/11*(i-1));
                sigmas(i) = mus(i)* sigma_f;
                sigmaln(i) = sqrt(log(sigmas(i)^2/mus(i)^2 + 1));
                muln(i) = log(mus(i)) - 0.5 * sigmaln(i)^2;
                lambdas(i,:) = lognrnd(muln(i), sigmaln(i),samples,1);
                if (mod(i,3) == 1)
                rs(i) = 1;
                else
                    if (mod(i,3) == 2)
                        rs(i) = 3;
                    else
                        rs(i) = 5;
                    end
                end
            end
        else
            display('input argument error, n can only be 5,50,or 100')
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Expected System downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%D_0 = sum(mus.*rs.*T) * ed_f;
p = lambdas .* T;
downtime = poissrnd(p') * rs';     
end