function [downtime]= exdownunisn(n,sigma_f,ed_f)
global mus;
%n=50;
T = 10;
samples = 40;
mu50 = 1.6;
mu100 = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two uniformly distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
if (n==5)
   for i = 1:n
        mus(i) = 1/(2*i);
        sigmas(i) = mus(i)* sigma_f;
        ls(i) = mus(i) - sqrt(3) * sigmas(i);
        us(i) = mus(i) + sqrt(3) * sigmas(i);
        lambdas(i) = ls(i) + sum(rand(samples,1)) * (1/samples) * (us(i)-ls(i));
        pdfs(i) = 1 / (us(i) - ls(i));
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
            mus(i) = 1/(mu50+1/6*(i-1));
            display(mus(i));
            sigmas(i) = mus(i)* sigma_f;
            ls(i) = mus(i) - sqrt(3) * sigmas(i);
            us(i) = mus(i) + sqrt(3) * sigmas(i);
            lambdas(i) = ls(i) + sum(rand(samples,1)) * (1/samples) * (us(i)-ls(i));
            pdfs(i) = 1 / (us(i) - ls(i));
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
                mus(i) = 1./(mu100+1/11*(i-1));
                display(mus(i));
                sigmas(i) = mus(i)* sigma_f;
                ls(i) = mus(i) - sqrt(3) * sigmas(i);
                us(i) = mus(i) + sqrt(3) * sigmas(i);
                lambdas(i) = ls(i) + sum(rand(samples,1)) * (1/samples) * (us(i)-ls(i));
                pdfs(i) = 1 / (us(i) - ls(i));
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

Bound = prod(us - ls);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Expected System downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D_0 = sum(mus.*rs.*T) * ed_f;
display(D_0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%System downtime inside integral part%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
downinte = sum(poissrnd(lambdas * T).*rs) * prod(pdfs)* Bound;

%%%%%%%%%%%%%%%%%%%%%%%System downtime by Monte carlo sampling%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
downtime = max(downinte-D_0, 0);
