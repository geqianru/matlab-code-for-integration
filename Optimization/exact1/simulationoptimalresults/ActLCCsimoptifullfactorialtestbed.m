function [simLCCosts,C_ap,C_rp,C_pp] = ActLCCsimoptifullfactorialtestbed(opts, D_0,Cas,Crfs,Rs,Mus,c_p)
T = 10; 

for j = 1: 10
    c_a(j) = Cas(opts(j)+1, j); 
    c_r(j) = Crfs(opts(j)+1, j);
    r(j) = Rs(opts(j)+1, j);
    mu(j) = Mus(opts(j)+1, j);
    %sigma(j) = Sigmas(opts(j)+1, j);
end

[simLCCosts,C_ap,C_rp,C_pp] = simLCC(c_a,c_r,r,mu,sigma,D_0,c_p);
end
