function [avg_gap, upper, lower, avg_simf, avg_st, Gapf] = stochasticresultscompare(n,ed_f)
sigma_f = [0.2 0.35 0.5]; 
    function avg_s1 = avgsim(n,sigma_f,ed_f)
     sample_1 = 10000;
     %d = zeros(sample_1,1);
       for i=1:sample_1
        d(i)= exMSlognormaln(n,sigma_f,ed_f);
        %display(n);
        %display(d(n));
       end
     avg_s1 = mean (d);
     %display(avg_s);
    end
    function avg_s2 = avgsimsigma(n, ed_f)
       for s = 1:length(sigma_f)
           avg_sim(s) =  avgsim(n,sigma_f(s), ed_f);
       end
       avg_s2 = mean(avg_sim);
      % display(avg_s2);
    end
avg_st = exMSstochastic (n,ed_f);
display(avg_st);
sample_2 = 50;
for m = 1:sample_2
    display(m);
    avg_s(m) = avgsimsigma(n, ed_f);
    display (avg_s(m));
    Gap(m) = abs(1 - avg_st./avg_s(m));
end
avg_simf = mean(avg_s);
Gapf = abs(1-avg_st./avg_simf);
 avg_gap = mean(Gap);
 upper = avg_simf + tinv(0.975,sample_2-1) * std(avg_s)/sqrt(sample_2); 
 lower = avg_simf - tinv(0.975,sample_2-1) * std(avg_s)/sqrt(sample_2);
 %Gupper = avg_gap + tinv(0.975,sample_2-1) * std(Gap)/sqrt(sample_2);
 %Glower = avg_gap - tinv(0.975,sample_2-1) * std(Gap)/sqrt(sample_2);
end













