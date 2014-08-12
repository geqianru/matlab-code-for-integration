
function [p]=pdg(a_1,b_1,r_1,a_2,b_2,r_2)
%%%%%%%%%%%%%%%%%%%%%n = 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t = cputime;
T = 10;
samples = 1;

%%%%%%%%%%%%%%%%%%%%%%%Monte Carlo part%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pdf_1 = 1/(b_1-a_1);
pdf_2 = 1/(b_2-a_2);
lambda_1 = a_1+rand(samples,1)*(b_1-a_1);
lambda_2 = a_2+rand(samples,1)*(b_2-a_2);
Bound = (b_1-a_1).*(b_2-a_2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%systme downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
downtime = (poissrnd(lambda_1*T) * r_1 + poissrnd(lambda_2*T) * r_2).* pdf_1.* pdf_2 ; 

%%%%%%%%%%%%%%%Approximate the randomness of lambda by Monte Carlo Method%%
p = sum(downtime)/samples.*Bound;
% e = cputime-t;
% display(e);
% hist(p);
%plot(x,y);
end