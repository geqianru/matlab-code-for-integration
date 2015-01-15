function [pavg_sim,e,mus,sigmas] = lognormalavgsim(n,sigma_f,ed_f)
t = cputime;
T = 10;
samples = 10000;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two uniformly distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
if (n==5)
   for i = 1:n
       mus(i) = 0.2 - (i-1) * 0.0450;
       sigmas(i) = mus(i) * sigma_f;
       sigmaln(i) = sqrt(log(sigmas(i)^2/mus(i)^2 + 1));
       muln(i) = log(mus(i)) - 0.5 * sigmaln(i)^2;
       lambdas(i,:) = lognrnd(muln(i), sigmaln(i),1,samples);
       display(lambdas(i,:));
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
            mus(i) = 0.2 - (i-1) * 0.0037;
            sigmas(i) = mus(i)* sigma_f;
            sigmaln(i) = sqrt(log(sigmas(i)^2/mus(i)^2 + 1));
            muln(i) = log(mus(i)) - 0.5 * sigmaln(i)^2;
            lambdas(i,:) = lognrnd(muln(i), sigmaln(i),1,samples);
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
                mus(i) = 0.2 - (i-1) * 0.0018;
                sigmas(i) = mus(i)* sigma_f;
                sigmaln(i) = sqrt(log(sigmas(i)^2/mus(i)^2 + 1));
                muln(i) = log(mus(i)) - 0.5 * sigmaln(i)^2;
                lambdas(i,:) = lognrnd(muln(i), sigmaln(i),1,samples);
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
D_0 = sum(mus.*rs.*T) * ed_f;
downtime = poissrnd(lambdas .* T)' * rs';
display(downtime);
exdowntime = max(downtime-D_0, 0);
pavg_sim = mean(exdowntime)/D_0;
e = cputime-t;
end