function [avg_gap,upper,lower,avg_sim,avg_a,Gap,avg_s,Gupper,Glower] = lognormalresultscompare(n,sigma_f,ed_f)
%global avg_s
%global Gap
%global avg_a
% global upper
% global lower
%global d
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

avg_a = exGammalognormaln(n,sigma_f,ed_f);
display(avg_a);
sample_2 = 50;
%Gap = zeros(sample_2,1);
 for m = 1:sample_2
     display(m);
     avg_s(m) = avgsim(n,sigma_f,ed_f);
     display(avg_s(m));
     Gap(m) = abs(1 - avg_a./avg_s(m));
     %display(m);
     %display(Gap(m));
 end
 avg_sim = mean(avg_s);
 stadev = std(avg_s);
 Gstadev = std(Gap);
 avg_gap = mean(Gap);
 upper = avg_sim + tinv(0.975,sample_2-1) * std(avg_s)/sqrt(sample_2); 
 lower = avg_sim - tinv(0.975,sample_2-1) * std(avg_s)/sqrt(sample_2);
 Gupper = avg_gap + tinv(0.975,sample_2-1) * std(Gap)/sqrt(sample_2);
 Glower = avg_gap - tinv(0.975,sample_2-1) * std(Gap)/sqrt(sample_2);
 %display (avg_sim);
 %display(avg_gap);
 
%  histnorm(d,50,'plot');
%  exdowntimegamman(n,sigma_f,ed_f);
 
end

