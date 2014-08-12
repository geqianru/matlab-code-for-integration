function [in3]= MCU3(b_1)
%t = cputime;
a_1 = 0.25;
%b_1 = 0.75;
r_1 = 2.5;
a_2 = 0.15;
b_2 = 0.65;
r_2 = 2;
a_3 = 0.10;
b_3 = 0.60;
r_3 = 1.5;
samples = 10000;
mu_1 = 0.5*(a_1+b_1);
mu_2 = 0.5*(a_2+b_2);
mu_3 = 0.5*(a_3+b_3);
pdf_1 = 1/(b_1-a_1);
pdf_2 = 1/(b_2-a_2);
pdf_3 = 1/(b_3-a_3);
x_1 = a_1+rand(samples,1)*(b_1-a_1);
x_2 = a_2+rand(samples,1)*(b_2-a_2);
x_3 = a_3+rand(samples,1)*(b_3-a_3);
Bound=(b_1-a_1).*(b_2-a_2).*(b_3-a_3);
T = 10;
c_p = 72000;
D_0 = (mu_1 * r_1 + mu_2 * r_2 + mu_3 * r_3) * T;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inside integral%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   function ii=yi(x_1,x_2,x_3,j1,j2,j3)
       ii=poisspdf(j1,x_1.*T).*poisspdf(j2,x_2.*T).*poisspdf(j3,x_3.*T);
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Convolution of the Possion part%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   function y1=pos(x_1,x_2,x_3) 
       sum = 0;
       for j1 = 1:30
           for j2 = 1:30
               for j3 = 1:30
                downcost = max(0,(j1-1) * r_1+(j2-1) * r_2+(j3-1) * r_3-D_0);
%                 display(i);
%                 display(j);
%                 display(downtime);
                sum = sum + yi(x_1,x_2,x_3,j1-1,j2-1,j3-1) * downcost;
               end
           end
       end
   y1 = sum .* pdf_1.* pdf_2.* pdf_3.* c_p;
   %display(y1);
  end

%%%%%%%%%%%%%%%Approximate the randomness of lambda by Monte Carlo Method%%
in3=sum(pos(x_1,x_2,x_3))/samples.*Bound;

%  e = cputime-t;
%  display(e);
display(in3);

end


