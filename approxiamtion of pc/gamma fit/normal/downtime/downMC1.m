function [exdowntime]= downMC1(mu_1,r_1)

T = 10;
D_0 = mu_1 * r_1 * T;
%display(D_0);
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two normal distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
sigma_1 = 0.1 * mu_1;
%sigma_2 = 0.4 * mu_2;
u_1 = mu_1 + 4 * sigma_1;
%u_2 = mu_2 + 3 * sigma_2;
l_1 = 0;
%l_2 = 0;
%samples = 1;
lambda_1 = l_1+rand * (u_1-l_1);
%lambda_2 = l_2+rand * (u_2-l_2);
pdf_1 = normpdf(lambda_1,mu_1,sigma_1);
%pdf_2 = normpdf(lambda_2,mu_2,sigma_2);
Bound = (u_1-l_1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%System downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
downtime = (poissrnd(lambda_1.*T) .* r_1) .* pdf_1 .* Bound;
%display(downtime);
exdowntime = max(downtime-D_0, 0);
%%%%%%%%%%%%%%%%%%%%%%%Monte carlo sampling%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%p = sum(downtime)/samples.*Bound;

end