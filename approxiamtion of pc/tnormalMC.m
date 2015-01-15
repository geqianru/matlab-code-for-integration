function [tnMC]= tnormalMC(mu_1)
 sigma_1 = 0.4 * mu_1;
% sigma_2 = 0.4 * mu_2;
 u_1 = mu_1 + 3 * sigma_1;
 %u_2 = mu_2 + 3 * sigma_2;
 l_1 = 0;
 %l_2 = 0;
 pd_1 = makedist('Normal','mu',mu_1,'sigma',sigma_1);
 %pd_2 = makedist('Normal','mu',mu_2,'sigma',sigma_2);
 t_1 = truncate(pd_1,l_1,u_1);
 %t_2 = truncate(pd_2,l_2,u_2);
 lambda_1 = random(t_1,100000,1);
 %lambda_2 = random(t_2,100000,1);
hist(lambda_1);
end
