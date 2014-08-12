function [avg_gap] = resultscompare(sigma_f,ed_f)
global avg_s
global Gap
global avg_a
global d
n=
function avg_s1 = avgsim(sigma_f,ed_f)
     sample_1 = 10000;
     %d = zeros(sample_1,1);
       for i=1:sample_1
        d(i)= exdownunis50(sigma_f,ed_f);
        %display(n);
        %display(d(n));
       end
     avg_s1 = mean (d);
     %display(avg_s);
end

avg_a = Downtimegammanexceed(n,sigma_f,ed_f);
display(avg_a);
sample_2 = 2;
%Gap = zeros(sample_2,1);
 for m = 1:sample_2
     display(m);
     avg_s(m) = avgsim(n,sigma_f,ed_f);
     %display(avg_s);
     Gap(m) = abs(1 - avg_a./avg_s(m));
     %display(m);
     display(Gap(m));
 end
 avg_sim = mean(avg_s);
 display (avg_sim);
 avg_gap = mean(Gap);
 display(avg_gap);
%  histnorm(d,50,'plot');
%  exdowntimegamman(n,sigma_f,ed_f);
 
end

