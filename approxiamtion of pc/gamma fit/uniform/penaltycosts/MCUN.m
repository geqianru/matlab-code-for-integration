function [inte] = MCUN(n)
t = cputime;
samples = 10000;

% pdf_1 = 1/(b_1-a_1);
% pdf_2 = 1/(b_2-a_2);
% x_1=a_1+rand(samples,1)*(b_1-a_1);
% x_2=a_2+rand(samples,1)*(b_2-a_2);

T = 10;
c_p = 72000;


  for i = 1:n
        a_i(i) = 0.25;
        b_i(i) = 0.75;
        r_i(i) = 1;
       mu_i(i) = 0.5 * (a_i(i) + b_i(i));
       pdf_i(i) = 1/(b_i(i)-a_i(i));
       x_i(i) = a_i(i)+rand(samples,1)*(b_i(i)-a_i(i));
  end
       
  D_0 = sum (mu_i .* r_i).*T ;
  %Bound=(b_1-a_1).*(b_2-a_2);
  Bound = prod(b_i-a_i);
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inside integral%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   function ii=yi(x_1,x_2,i,j)
            %ii=poisspdf(i,x_1.*T).*poisspdf(j,x_2.*T);
            for i = 1:n
                ii
              end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Convolution of the Possion part%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  function y1=pos(x_1,x_2) 
   sum = 0;
    for i = 1:30
        for j = 1:30
                downcost = max(0,(i-1) * r_1+(j-1) * r_2-D_0);
%                 display(i);
%                 display(j);
%                 display(downtime);
                sum=sum+yi(x_1,x_2,i-1,j-1) * downcost; 
        end
    end
   y1 = sum .* pdf_1.* pdf_2.*c_p;
   %display(y1);
  end

%%%%%%%%%%%%%%%Approximate the randomness of lambda by Monte Carlo Method%%
inte=sum(pos(x_1,x_2))/samples.*Bound;

e = cputime-t;
display(e);
display(inte);

end


