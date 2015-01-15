function [exdowntime] = expecteddtlognormal(n,ed_f)
T = 10;
%samples = 10000;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two uniformly distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
  if (n==5)
    for i = 1:n
        mus(i) = 0.2 - (i-1) * 0.0450;
        if (mod(i,3) == 1)
            rs(i) = 1;
        else
            if (mod(i,3) == 2)
                rs(i) = 3;
            else
                rs(i) = 5; 
            end
        end
    end
  else
      if (n==50)
          for i = 1:n
            mus(i) = 0.2 - (i-1) * 0.0037;           
            if (mod(i,3) == 1)
                rs(i) = 1;
            else
                if (mod(i,3) == 2)
                    rs(i) = 3;
                else
                    rs(i) = 5;
                end
            end
          end
      else
          if (n==100)
            for i = 1:n
                mus(i) = 0.2 - (i-1) * 0.0018;
                if (mod(i,3) == 1)
                rs(i) = 1;
                else
                    if (mod(i,3) == 2)
                        rs(i) = 3;
                    else
                        rs(i) = 5;
                    end
                end
            end
          else
              display('input argument error, n can only be 5,50,or 100')
          end
      end
  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Expected System downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D_0 = sum(mus .* rs .* T) * ed_f;
downtime = (mus .* T) * rs';
exdowntime = max( downtime - D_0, 0);
end