function [inte] = MCNN(n)
t = cputime;
  samples = 10000;
  T = 10;
  c_p = 72000;
  lambdas = zeros(samples,1);
  lambda = zeros(samples,n);
  pdfs = zeros(samples,n);
  for i = 1:n
        rs(i) = 1;
       mus(i) = 0.5;
       sigmas(i) = mus(i).*0.4;
       us(i) = mus(i)+3.*sigmas(i);
       ls(i) = 0;
       lambda(:,i) = ls(i)+rand(samples,1)*(us(i)-ls(i));
       pdfs(:,i) = normpdf(lambda(:,i),mus(i),sigmas(i));
       lambdas = lambdas + lambda(:,i);
  end          
D_0 = sum (mus .* rs).*T ;
Bound = prod(us-ls);
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inside integral%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    function ii=yi(x,i)
%             ii=poisspdf(i,x.*T);
%    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Convolution of the Possion part%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  function y1=pos(x1) 
   sum = 0;
    for i = 1:3000
          downcost = max(0,(i-1).* rs(1)-D_0);
          sum = sum + poisspdf(i-1,x1.*T).* downcost; 
    end
   y1 = sum .* prod(pdfs')'.*c_p;
   %display(y1);
  end

%%%%%%%%%%%%%%%Approximate the randomness of lambda by Monte Carlo Method%%
inte = sum(pos(lambdas))/samples.*Bound;

e = cputime-t;
display(e);
display(inte);

end