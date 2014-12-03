function [penaltycost]= simpenaltycosts(r,mu,sigma,T,D_0,c_p)
%c_p = 1000;
for i = 1:length(mu)
    sigmaln(i) = sqrt(log(sigma(i)^2/mu(i)^2 + 1));
    muln(i) = log(mu(i)) - 0.5 * sigmaln(i)^2;
    lambdas(i,:) = lognrnd(muln(i), sigmaln(i),1,10000);
end   
downtime = poissrnd(lambdas .* T)' * r';
extradowntime = max(downtime - D_0, 0);
avg_sim = mean(extradowntime);
penaltycost = avg_sim * c_p;
end