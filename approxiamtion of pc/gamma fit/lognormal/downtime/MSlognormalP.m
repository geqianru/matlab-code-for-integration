function [downtime]= MSlognormalP(mu_1,r_1)
T = 10;
sigma_1 = 0.4 * mu_1;
sigmaln = sqrt(log(sigma_1^2/mu_1^2 + 1));
muln = log(mu_1) - 0.5 * sigmaln^2;
%u_1 = 4;
%lambda_1 = lognrnd(muln,sigmaln);
x = (0:0.02:10);
y = lognpdf(x,muln,sigmaln);
plot(x,y); grid;
xlabel('x'); ylabel('p')
% Bound = u_1;
%downtime = poissrnd(lambda_1.*T) .* r_1;
% D_0 = muln * r_1 * T; 
% exdowntime = max(downtime-D_0, 0);
end