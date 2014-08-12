function [downtime]= downMCN(n)

T = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two normal distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
for i = 1:n
      if i<=5
        mus(i) = 0.5; 
        rs(i) = 2.5;
      elseif (i>5)&&(i<=10)
        mus(i) = 0.4;
        rs(i) = 2;
      elseif (i>10)&&(i<=15)
        mus(i) = 0.3;
        rs(i) = 1.5;
      elseif (i>15)&&(i<=20)
        mus(i) = 0.2;
        rs(i) = 1;
      else (i>30)&&(i<=35)
        mus(i) = 0.10;
        rs(i) = 0.5;
      end
        sigmas(i) = mus(i)*0.4;
        us(i) = mus(i) + 3 * sigmas(i);
        ls(i) = 0;
        lambdas(i) = ls(i) + rand * (us(i)-ls(i));
        pdfs(i) = normpdf(lambdas(i),mus(i),sigmas(i));
 end

Bound = prod(us - ls);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%System downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%downtime = (poissrnd(lambda_1.*T) .* r_1 + poissrnd(lambda_2.*T) * r_2) .* pdf_1 .* pdf_2 * Bound;
downtime = sum(poissrnd(lambdas * T).*rs) * prod(pdfs) * Bound;

%%%%%%%%%%%%%%%%%%%%%%%Monte carlo sampling%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%p = sum(downtime)/samples.*Bound;


end