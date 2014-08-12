function avg_s = avgsim(n,sigma_f,ed_f)
     sample_1 = 10000;
     %d = zeros(sample_1,1);
       for i=1:sample_1
        d(i)= exdownunisn(n,sigma_f,ed_f);
        %display(n);
        %display(d(n));
       end
     avg_s = mean (d);
     %display(avg_s);
   end