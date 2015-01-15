function [inte] = MC(mu_1,r_1,mu_2,r_2)
t = cputime; 
sigma_1=0.4*mu_1;
sigma_2=0.4*mu_2;
u_1=mu_1+3.*sigma_1;
u_2=mu_2+3.*sigma_2;
l_1=0;
l_2=0;
samples = 10000;
lambda_1=l_1+rand(samples,1)*(u_1-l_1);
lambda_2=l_2+rand(samples,1)*(u_2-l_2);
Bound=(u_1-l_1).*(u_2-l_2);
T=10;
c_p=72000;
D_0=(mu_1*r_1+mu_2*r_2)*10;
display(1);
%%%%%%%%%%%%%%%%%%%%%%%%inside integral%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   function ii=yi(lambda_1,lambda_2,i,j)
            ii=poisspdf(i,lambda_1.*T).*poisspdf(j,lambda_2.*T);
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Convolution of the Possion part%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   function y1=pos(lambda_1,lambda_2)
            sum=0;
               for i=1:30
                   for j=1:30
             downtime=(i-1).*r_1+(j-1).*r_2;
%            display(i);
%            display(j);
%            display(downtime);
             sum=sum+yi(lambda_1,lambda_2,i-1,j-1).* max(0,downtime-D_0); 
                   end
               end
    y1=sum .* normpdf(lambda_1,mu_1,sigma_1).* normpdf(lambda_2,mu_2,sigma_2).*c_p;
    %display(y1);
   end

%%%%%%%%%%%%%%%Approximate the randomness of lambda by Monte Carlo Method%%
inte=sum(pos(lambda_1,lambda_2))/samples.*Bound;

e = cputime-t;
display(e);
display(inte);
% plot([0:1:31],intes)
end


















