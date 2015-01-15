function [pavg_sim]= exdownunisn(n,sigma_f,ed_f)
%monte calor simulation for exceeded downtime under uniform distributed failure rates of the components%
%global mus;
%n=50;
T = 10;
samples = 10000;
%mu50 = 1.6;
%mu100 = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two uniformly distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
if (n==5)
   for i = 1:n
        mus(i) = 1/(2*i);
        sigmas(i) = mus(i)* sigma_f;
        ls(i) = mus(i) - sqrt(3) * sigmas(i);
        us(i) = mus(i) + sqrt(3) * sigmas(i);
        lambdas(i,:) = ls(i) + rand(samples,1) * (us(i)-ls(i));
        %display(lambdas(:,i));
        %pdfs(i) = 1 / (us(i) - ls(i));
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
            mus(i) = 1/(1 + (1/5.5)*(i-1));
            %display(mus(i));
            sigmas(i) = mus(i)* sigma_f;
            ls(i) = mus(i) - sqrt(3) * sigmas(i);
            us(i) = mus(i) + sqrt(3) * sigmas(i);
            lambdas(i,:) = ls(i) + rand(samples,1) * (us(i)-ls(i));
            %pdfs(i) = 1 / (us(i) - ls(i));
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
                mus(i) = 1/(1 + 1/11*(i-1));
                %display(mus(i));
                sigmas(i) = mus(i)* sigma_f;
                ls(i) = mus(i) - sqrt(3) * sigmas(i);
                us(i) = mus(i) + sqrt(3) * sigmas(i);
                lambdas(i,:) = ls(i) + rand(samples,1) * (us(i)-ls(i));
                %pdfs(i) = 1 / (us(i) - ls(i));
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
%display(mus);
%Bound = prod(us - ls);
%display (lambdas);
%display (rs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Expected System downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D_0 = sum(mus.*rs.*T) .* ed_f;
display(D_0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%System downtime inside integral part%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sample_2 = 1;
% %display (lambdas);
% ps = zeros(1,n);
% for j = 1:sample_2
%     ps = ps + poissrnd(lambdas * T);
% end
% p = ps./sample_2;
% %display (p);
% downinte = sum(p.*rs);
% %display(downinte);

p = lambdas .* T;
downinte = poissrnd(p') * rs';
%display(D_0);
%up = (poissrnd(us * T) * rs');
%display (up);
%display(rs);
%%%%%%%%%%%%%%%%%%%%%%%System downtime by Monte carlo sampling%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exdowntime = max(downinte-D_0, 0);
pavg_sim = mean(exdowntime)/D_0;
%display(downtime);
