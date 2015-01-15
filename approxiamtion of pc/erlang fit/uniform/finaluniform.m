 clear all;
counter = 0;
n = [5 50 100];
sigma_f = [0.2 0.35 0.5];
%sigma_f = 0.35;
ed_f = [1 1.1 1.2 1.3];
for ni = 1:length(n)
    %for sj = 1:length(sigma_f)
        for ek = 1:length(ed_f)
            counter = counter + 1;
            [avg_gap(counter,:),upper(counter,:),lower(counter,:),pavg_sim(counter,:),pavg_a(counter,:),pavg_s(counter,:),rel_gap(counter,:),max_gap(counter,:)] = erlonglogresultscompare(n(ni),sigma_f,ed_f(ek));
            %save('D:\MATLAB\approxiamtion of pc\gamma fit\uniform\gap values\compareresult(n,sigma,ed_f.mat');
            %save compareresult(n,sigma,1+(k-1)/10).mat;        
        end
    %end
end

