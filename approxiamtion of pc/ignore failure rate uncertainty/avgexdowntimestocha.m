function [avg_sf,upper, lower] = avgexdowntimestocha(n, ed_f)
sample = 50;
  for m = 1:sample
      %display(m);
      avg_s(m) = exMSstochastic (n,ed_f);      
  end
  avg_sf = mean(avg_s);
  upper = avg_sf + tinv(0.975,sample - 1) * std(avg_s)/sqrt(sample); 
  lower = avg_sf - tinv(0.975,sample - 1) * std(avg_s)/sqrt(sample); 
end