function [downtime]= downtime1(mu_1,r_1)
T = 10;
sigma_1 = 0.4 * mu_1;
pd = makedist('Normal','mu',mu_1,'sigma',sigma_1);
t = truncate(pd,0,inf);
lambda = random(t,1);
downtime = poissrnd(lambda.*T) .* r_1;
display(downtime);
end