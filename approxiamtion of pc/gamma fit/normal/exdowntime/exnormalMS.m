function [avg_sim] = exnormalMS(n,sigma_f,ed_f)
T = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two normal distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
if (n==5)  
   for i = 1:n
        mus(i) = 1/(2*i);
        sigmas(i) = mus(i) * sigma_f;
        pd = makedist('Normal','mu',mus(i),'sigma',sigmas(i));
        t = truncate(pd,0,inf);
        lambdas(i,:) = random(t,10000,1);
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
            pd = makedist('Normal','mu',mus(i),'sigma',sigmas(i));
            t = truncate(pd,0,inf);
            lambdas(i) = random(t,10000,1);
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
            pd = makedist('Normal','mu',mus(i),'sigma',sigmas(i));
            t = truncate(pd,0,inf);
            lambdas(i) = random(t,10000,1);
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
D_0 = sum(mus.*rs.*T)*ed_f;
downtime = poissrnd(lambdas * T)' * rs';
exdowntime = max(downtime-D_0, 0);
avg_sim = mean(exdowntime);
end