function c_v = mixerlanghexpcv(rs,mus,sigmas)
T = 10;
% mus = [0.1 0.2];
% rs = [1 2];
% sigmas = [0.4 0.4];

for i = 1:length(mus)
    ss(i) = mus(i);
    v1(i) = sigmas(i)^2 * T^2 * rs(i)^2;
    v2(i) = mus(i) * T * rs(i)^2;
end
M_1 = sum (ss);
Variance = sum(v1) + sum(v2);
c_v = sqrt(Variance)/(M_1);
display (c_v);
% lambda_1 = 2 / M_1 * (1 + sqrt((c_v^2 - 0.5)/(c_v^2 + 1)));
% lambda_2 = 4 / M_1 - lambda_1;
% q = lambda_1 * (lambda_2 * M_1 - 1)/(lambda_2 - lambda_1);
k = 
display(k);
%%%%%%pdf of a erlang(1,k) distribution
    function pder1 = erlang1kpdf(Lambda_1, Lambda_2, Q)
        pder1 = q * (1-)
    end
        
end