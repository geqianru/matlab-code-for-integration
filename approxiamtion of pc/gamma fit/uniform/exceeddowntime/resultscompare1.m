function [avg_gap] = resultscompare1(n,sigma_f,ed_f)

sample_1 = 100;
%d = zeros(sample_1,1);
for i=1:sample_1
 d(i)= exdownunisn(n,sigma_f,ed_f);
 %display(n);
 %display(d(n));
end
avg_s = mean (d);
display(avg_s);
%display(avg_s);
histnorm(d,50,'plot'); hold on
avg_a = Downtimegammanexceed(n,sigma_f,ed_f);
display(avg_a);
avg_gap = abs(1 - avg_a/avg_s);
display(avg_gap);
exdowntimegamman(n,sigma_f,ed_f); 
end