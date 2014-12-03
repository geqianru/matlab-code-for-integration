function [simLCCosts,C_ap,C_rp,C_pp]=simLCC(c_a,c_r,r,mu,sigma,D_0,c_p)
T = 10;
C_a = sum(c_a);
%display(C_a);
C_r = sum(mu .* c_r .* T);
%display(C_r);
C_p = simpenaltycosts(r,mu,sigma,T,D_0,c_p); 
%display(C_p);
simLCCosts = C_a + C_r + C_p;
%display(LLcosts)
% compute the proportion of each cost in the LCC cost 
C_ap = C_a / simLCCosts;
C_rp = C_r / simLCCosts;
C_pp = C_p / simLCCosts;
end