 function [inte] = MCNN(n)
%t = cputime;
%%%%%%%%%%%%%%Parameter setting for the component distribution%%%%%%%%%%%%%
  samples = 1;
  T = 10;
  
   for i = 1:n
      if i<=5
        mus(i) = 0.5;
        sigmas(i) = mus(i)*0.4;
        rs(i) = 2.5;
      elseif (i>5)&&(i<=10)
        mus(i) = 0.4;
        sigmas(i) = mus(i)*0.4;
        rs(i) = 2;
      elseif (i>10)&&(i<=15)
        mus(i) = 0.3;
        sigmas(i) = mus(i)*0.4;
        rs(i) = 1.5;
      elseif (i>15)&&(i<=20)
        mus(i) = 0.2;
        sigmas(i) = mus(i)*0.4;
        rs(i) = 1;
      else (i>30)&&(i<=100)
        mus(i) = 0.10;
        sigmas(i) = 0.40;
        rs(i) = 1;
      end
       ls(i) = 0;
       us(i) = ls(i)+ 3 * sigmas(i);
  end
 
Bound = prod(us-ls);
lambdas = normrnd(mus,sigmas);
pdfn = normpdf(lambdas,mus,sigmas);
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%system downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
downtime = sum((poissrnd(lambdas.*T)).*rs)*prod(pdfn);

%%%%%%%%%%%%%%%Approximate the randomness of lambda by Monte Carlo Method%%
inte = sum(downtime)/samples * Bound;
%e = cputime-t;
%display(e);
%display(inte);

end