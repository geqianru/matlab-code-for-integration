function [penaltycost,c_v]= mixerlanglognormalpenalty(r,mu,sigma,T,D_0,c_p)
%c_p = 1000;
ss = mu .* T .* r;
v1 = sigma.^2 .* T^2 .* r.^2;
v2 = mu .* T .* r.^2;
M_1 = sum (ss);
Variance = sum(v1) + sum(v2);
c_v = sqrt(Variance)/(M_1);
%display(c_v);
k = ceil(1/c_v^2);
q = 1/(1 + c_v^2) .* (k .* c_v^2 - sqrt( k .* (1 + c_v^2) - k^2 .* c_v^2));
theta = (k - q)/(M_1);
avg_a1 = D_0*(1-(q * gamcdf(D_0,k-1,1./theta)+(1-q)*gamcdf(D_0,k,1./theta)));
avg_a = q * (k-1) / theta * (1 - gamcdf(D_0,k,1./theta)) + k * (1-q) / theta * (1-gamcdf(D_0,k+1,1./theta))-avg_a1;
penaltycost = c_p * avg_a;
end