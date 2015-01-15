function [downtime]= downMC(mu_1,r_1,mu_2,r_2)

T = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two normal distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
sigma_1 = 0.4 * mu_1;
sigma_2 = 0.4 * mu_2;
u_1 = mu_1 + 3 * sigma_1;
u_2 = mu_2 + 3 * sigma_2;
l_1 = 0;
l_2 = 0;
%samples = 1;
lambda_1 = l_1+rand * (u_1-l_1);
lambda_2 = l_2+rand * (u_2-l_2);
pdf_1 = normpdf(lambda_1,mu_1,sigma_1);
pdf_2 = normpdf(lambda_2,mu_2,sigma_2);
Bound = (u_1-l_1) * (u_2-l_2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%System downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
downtime = (poissrnd(lambda_1.*T) .* r_1 + poissrnd(lambda_2.*T) * r_2);
display(downtime);

%%%%%%%%%%%%%%%%%%%%%%%Monte carlo sampling%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%p = sum(downtime)/samples.*Bound;


end