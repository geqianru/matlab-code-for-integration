function [stochnumLCCcost,C_ap,C_rp,C_pp] = stochnumLCC(c_a,c_r,r,mu,D_0,c_p)
T = 10;
C_a = sum(c_a);
%display(C_a);
C_r = sum(mu .* c_r .* T);
%display(C_r);
C_p = stochnumpenalty(r,mu,T,D_0,c_p);
%display(C_p);
stochnumLCCcost = C_a + C_r + C_p;
%display(LLcosts);
C_ap = C_a / stochnumLCCcost;
C_rp = C_r / stochnumLCCcost;
C_pp = C_p / stochnumLCCcost;
end