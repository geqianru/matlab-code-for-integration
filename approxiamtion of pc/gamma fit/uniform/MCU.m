function [inte] = MCU(a_1,b_1,a_2,b_2,r_1,r_2)
t = cputime;
samples = 10000;
mu_1 = 0.5*(a_1+b_1);
mu_2 = 0.5*(a_2+b_2);
pdf_1 = 1/(b_1-a_1);
pdf_2 = 1/(b_2-a_2);
x_1=a_1+rand(samples,1)*(b_1-a_1);
x_2=a_2+rand(samples,1)*(b_2-a_2);
Bound=(b_1-a_1).*(b_2-a_2);
T = 10;
c_p = 72000;
D_0 = (mu_1 * r_1 + mu_2 * r_2) * T;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inside integral%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   function ii=yi(x_1,x_2,i,j)
            ii=poisspdf(i,x_1.*T).*poisspdf(j,x_2.*T);
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


