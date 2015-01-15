function [avg_gap,upper,lower,pavg_sim,pavg_a,pavg_s,rel_gap,max_gap,e] = erlonglogresultscompare(n,sigma_f,ed_f)
t = cputime;
pavg_a = mixerlanglognormaln(n,sigma_f,ed_f);
display(pavg_a);
sample_2 = 50;
 for m = 1:sample_2
     %display(m);
     pavg_s(m) = lognormalavgsim(n,sigma_f,ed_f);
     display(pavg_s(m));
     gaps(m) = abs(pavg_s(m)-pavg_a);
 end
 pavg_sim = mean(pavg_s);
 avg_gap = abs(pavg_a - pavg_sim);
 rel_gap = abs(1-pavg_a./pavg_sim);
 max_gap = max(gaps);
 upper = pavg_sim + tinv(0.975,sample_2-1) * std(pavg_s)/sqrt(sample_2); 
 lower = pavg_sim - tinv(0.975,sample_2-1) * std(pavg_s)/sqrt(sample_2); 
 e = cputime-t;
end

