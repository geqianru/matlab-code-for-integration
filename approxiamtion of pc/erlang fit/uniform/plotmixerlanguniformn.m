function [k] = plotmixerlanguniformn(n,sigma_f)
T = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%Parameter setting of the distribution of these two uniformly distributed lambdas%%%%%%%%%%%%%%%%%%%%%%% 
if (n==5)
   for i = 1:n
       mus(i) = 1/(2*i);
       sigmas(i) = mus(i) * sigma_f;
       as(i) = mus(i) - sqrt(3) * sigmas(i);
       bs(i) = mus(i) + sqrt(3) * sigmas(i);
       if (mod(i,3) == 1)
            rs(i) = 1;
       else
            if (mod(i,3) == 2)
                rs(i) = 3;
            else
                rs(i) = 5; 
            end
       end
       sems(i) = (T^2) * (rs(i)^2) * (as(i)^2 + as(i) * bs(i) + bs(i )^2)/3;
       ss(i) = mus(i) * T * rs(i);
       v1(i) = sigmas(i)^2 * T^2 * rs(i)^2;
       v2(i) = mus(i) * T * rs(i)^2;
       %v3(i) = mus(i)^2 * T^2 * rs(i)^2;     
   end
else
    if (n==50)
        for i = 1:n
            mus(i) = 1/(1 + (1/5.5)*(i-1));
            sigmas(i) = mus(i)* sigma_f;
            as(i) = mus(i) - sqrt(3) * sigmas(i);
            bs(i) = mus(i) + sqrt(3) * sigmas(i);
            if (mod(i,3) == 1)
                rs(i) = 1;
            else
                if (mod(i,3) == 2)
                    rs(i) = 3;
                else
                    rs(i) = 5;
                end
            end
            sems(i) = (T^2) * (rs(i)^2) * (as(i)^2 + as(i) * bs(i) + bs(i)^2);
            ss(i) = mus(i) * T * rs(i);
            v1(i) = sigmas(i)^2 * T^2 * rs(i)^2;
            v2(i) = mus(i) * T * rs(i)^2;
            %v3(i) = mus(i)^2 * T^2 * rs(i)^2;    
        end
    else
        if (n==100)
            for i = 1:n
                mus(i) = 1/(1 + 1/11*(i-1));
                sigmas(i) = mus(i)* sigma_f;
                as(i) = mus(i) - sqrt(3) * sigmas(i);
                bs(i) = mus(i) + sqrt(3) * sigmas(i);
                if (mod(i,3) == 1)
                rs(i) = 1;
                else
                    if (mod(i,3) == 2)
                        rs(i) = 3;
                    else
                        rs(i) = 5;
                    end
                end
                sems(i) = (T^2) * (rs(i)^2) * (mus(i)^2+sigmas(i)^2);
                ss(i) = mus(i) * T * rs(i);
                v1(i) = sigmas(i)^2 * T^2 * rs(i)^2;
                v2(i) = mus(i) * T * rs(i)^2;
                %v3(i) = mus(i)^2 * T^2 * rs(i)^2;              
            end
        else
            display('input argument error, n can only be 5,50,or 100')
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%Mean of downtime%%%%%%%%%%%%%%%%%%%%%%%
 M_1 = sum (ss);
% %%%%%%%%%%%%%%%%%%%%%%%Variance of downtime%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Variance = sum(v1) + sum(v2);
%%%%%%%Coefficent of variation
 c_v = sqrt(Variance)/(M_1);
%%%%%%%%%%%%%%%%%%%estimate parameter k,q,theta in the erlang distribution
k = ceil(1/c_v^2);
q = 1/(1 + c_v^2) .* (k .* c_v^2 - sqrt( k .* (1 + c_v^2) - k^2 .* c_v^2));
theta = (k - q)/(M_1);

%%%%%%%%%%%define a erlang(theta,k) pdf function
    function p = erlangpdf(x,K,Theta)
        p = Theta.^K .* exp(1).^(-Theta*x) .* x.^(K-1)/factorial(K-1);
    end

%%%%%%%%%%%Define the cdf function of erlang(theta, k)distribution
    function c = erlangcdf(x,K,Theta)
        c = 1 - symsum((Theta*x).^j.*exp(1)^(-Theta*x)/factorial(j),j,0,k-1);
    end

%%%%%%pdf of a erlang(k-1,k) distribution
    function pder1 = erlangkpdf(x,K,Theta)
        pder1 = q * erlangpdf(x,K-1,Theta) + (1-q) * erlangpdf(x,K,Theta);
    end
%%%%%%Cdf of a erlang(k-1,k) distribution
    function cder1 = erlangkcdf(x,K,Theta)
        cder1 = q * erlangcdf(x,K-1,Theta)  + (1-q) * erlangcdf(x,K,Theta);
    end
%%%%%%compute the ln(k-1)! part for the lner(k,k-1), er(k,k-1) is the pdf
%%%%%%of a er(k,k-1,x)function, given the x^(k-1)equals to inf when x
%%%%%%became large, first compute lner(k,k-1),then compute e^(lner(k,k-1))
y_ln = 0;
for j = 2:1:k-2    
y_ln = y_ln + log(j);
j = j + 1;
end


if (n==5)
  x_1 = 1:1:100; 
  y_1 = erlangkpdf(x_1,k,theta);
  d = downunin(n,sigma_f);
  sskernel(d); hold on
  plot(x_1,y_1,'Color','r','LineWidth',1);  hold off
else
    if(n==50)
        x_1 = 200:1:800;
        y_1 = erlangkpdf(x_1,k,theta);
        d = downunin(n,sigma_f);
        sskernel(d);  hold on
        plot(x_1,y_1,'Color','r','LineWidth',1);  hold off
    else
        x_1 = 500:1:1200;
        %%%%%%compute the rest part for the lnerpdf(k,k-1)
        y = -theta * x_1 + (k-2) * log(x_1) + (k-1) * log(theta) + log( q + (1-q) * theta * x_1/(k-1)) - y_ln ;
        y_1 = exp(y);
        d = downunin(n,sigma_f);
        sskernel(d); hold on
        plot(x_1,y_1,'Color','r','LineWidth',1);  hold off
    end
end
ym = max(y_1);
ylim([0 ceil(ym*115)/100])
           
end