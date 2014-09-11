% fitting plot script
clear all
close all
clc
% cases to consider
mu = 5;
sigma = [3 4 5 6];
k = [2 3 10];
% do the fitting
figure;
set(gcf, 'color', 'white');
subplot(length(sigma),length(k),1);
for ki=1:length(k)
    M = fitMMPPmoments(mu,sigma,k(ki));
    for n=1:length(sigma);
        Q = [-M(n,2), M(n,2); M(n,1)*M(n,2), -M(n,1)*M(n,2)];
        lambda = [0, M(n,3)];
        PMF = ComputeMMPPpmf(Q,lambda,1);
        pmf = Q(2,1)/(Q(2,1)+Q(1,2)) * PMF(1,:) + ...
              Q(1,2)/(Q(2,1)+Q(1,2)) * PMF(2,:);
        subplot(length(sigma),length(k),(n-1)*length(k)+ki);
        bar(0:length(pmf)-1,pmf);
        titlestring = strcat('\mu=',num2str(mu),', \sigma=',num2str(sigma(n)),', \kappa=',num2str(k(ki)));
        title(titlestring,'FontName','umbxti10');
        axis([-0.8, 20+n*5, 0, max(pmf)+0.02])
        xlabel('n','fontsize',12,'FontName','umbxti10')
        ylabel('P\{N=n\}','fontsize',12,'FontName','umbxti10')
    end
end
