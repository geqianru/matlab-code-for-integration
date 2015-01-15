clear all;
counter = 0;
n = [5 50 100];
sigma_f = [0.2 0.5 1];
ed_f = [1 1.1 1.2 1.3 1.4];
for ni = 1:length(n)
    for sj = 1:length(sigma_f)
        for ek = 1:length(ed_f)
            counter = counter + 1;
            display (counter);
            [avg_gap(counter,:),upper(counter,:),lower(counter,:),pavg_sim(counter,:),pavg_a(counter,:),pavg_s(counter,:),rel_gap(counter,:),max_gap(counter,:)] = lognormalresultscompare(n(ni),sigma_f(sj),ed_f(ek));
            %save('D:\MATLAB\approxiamtion of pc\gamma fit\uniform\gap values\compareresult(n,sigma,ed_f.mat');
            %save compareresult(n,sigma,1+(k-1)/10).mat;        
        end
    end
end

