function [y] = rdifferent(n)
t = cputime;
  T = 10;
  samples = 10000;
  lambdas = zeros(samples,n);
  %s = [1:30];
  pdfs = zeros(n,1);
  for i = 1:n
      if i<=1
        as(i) = 0.25;
        bs(i) = 0.75;
        rs(i) = 2.5;
      elseif (i>=2)&&(i<=10)
        as(i) = 0.15;
        bs(i) = 0.65;
        rs(i) = 2;
      elseif (i>40)&&(i<=60)
        as(i) = 0.10;
        bs(i) = 0.60;
        rs(i) = 1.5;
      elseif (i>60)&&(i<=80)
        as(i) = 0.15;
        bs(i) = 0.45;
        rs(i) = 1;
      else (i>80)&&(i<=100)
        as(i) = 0.10;
        bs(i) = 0.40;
        rs(i) = 1;
      end
       mus(i) = 0.5 * (as(i) + bs(i));
       lambdas(:,i) = as(i)+rand(samples,1)*(bs(i)-as(i));
       pdfs(i) = 1/(bs(i)-as(i));
       %ps(i) = sum(poisspdf([1:30], lambdas(i)));
  end
D_0 = sum(mus.*rs) * T ;
c_p = 72000;
Bound = prod(bs-as);
sums = 0; 
   for j1 = 1:50
       display(j1);
       for j2 = 1:50
           display(j2)
%            for j3 = 1:10
%                %display(j3)
%                for j4 = 1:10
%                   %display(j4)
                  p = poisspdf(j1-1,lambdas(:,1)).* poisspdf(j2-1,lambdas(:,2));
                  %.* poisspdf(j3,lambdas(:,3)).* poisspdf(j4,lambdas(:,4));
                  sums = sums + p.*max(0,((j1-1)*rs(1)+(j2-1)*rs(2)-D_0));
                  %+j3*rs(3)+j4*rs(4)
                  %display (sums);
%               end
%            end
       end
   end
   inte = sums.*prod(pdfs).*c_p; 
   y = sum(inte)/samples.*Bound;
   e = cputime-t;
%    display(inte);
%    display(y);
end
   


 
 

