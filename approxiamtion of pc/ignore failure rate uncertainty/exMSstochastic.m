%compute the exceeded downtime for model ignore the uncertainty of the failure rate 
function [pavg_simexstoch] = exMSstochastic(n, ed_f)
%t = cputime;
T = 10;
samples = 10000;
   if (n==5)
       for i = 1:n
           mus(i,:) = (0.2 - (i-1) * 0.0450) .* ones(1,samples);
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
               mus(i,:) = (0.2 - (i-1) * 0.0037).* ones(1, samples);
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
                   mus(i,:) = (0.2 - (i-1) * 0.0018).* ones(1, samples);
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
D_0 = sum(rs * mus(:,1).* T) * ed_f;
downtime = rs * poissrnd(mus .* T);
exdowntime =  max(downtime - D_0, 0);
pavg_simexstoch = mean(exdowntime)/D_0;
%e = cputime - t;
end