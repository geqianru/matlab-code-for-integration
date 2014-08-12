function [downtime]= downunin(n)

T = 10;
samples = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two normal distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
for i = 1:n
        mus(i) = 1/(2*i);
        sigmas(i) = mus(i)*0.2;
        ls(i) = mus(i) - sqrt(3) * sigmas(i);
        us(i) = mus(i) + sqrt(3) * sigmas(i);
        lambdas(i) = ls(i) + rand(samples,1) * (us(i)-ls(i));
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

Bound = prod(us - ls);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%System downtime inside integral part%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%downtime = (poissrnd(lambda_1.*T) .* r_1 + poissrnd(lambda_2.*T) * r_2) .* pdf_1 .* pdf_2 * Bound;
downinte = sum(poissrnd(lambdas * T).*rs) * prod(pdfs);

%%%%%%%%%%%%%%%%%%%%%%%System downtime by Monte carlo sampling%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
downtime = sum(downinte)/samples.*Bound;


end