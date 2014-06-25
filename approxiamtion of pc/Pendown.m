%traditional way(Adaptive Quadrature) of computing penalty cost%
function[Pen]=Pendown(mu_1,mu_2,r_1,r_2)
   t = cputime;
   T=10;
   D_0=(mu_1+mu_2)*10-1;
   sigma_1=mu_1.*0.4;
   sigma_2=mu_2.*0.4;
   c_p=72000;

%%%%%%%%%%%%%%%%%%%%%%%%inside integral%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   function ii=yi(lambda_1,lambda_2,i,j)
            ii=poisspdf(i,lambda_1*T)*poisspdf(j,lambda_2*T);
   end


%%%%%%%%%%%%%%%%%%%%%%%convolution for the possion part%%%%%%%%%%%%%%%%%%%%
   function y1=pos(lambda_1,lambda_2)
            display(lambda_1);
            sum = 0;
                for i =1:10
                    for j=1:10
                downtime =(i-1).*r_1+(j-1).*r_2;
                display(i);
                display(j);
                display(downtime);
                sum = sum + yi(lambda_1,lambda_2,i-1,j-1).* max(0,downtime-D_0).* c_p;
                display(sum);
                    end
                end
            y1=sum .* normpdf(lambda_1,mu_1,sigma_1).* normpdf(lambda_2,mu_2,sigma_2); %(sum(Pend(i,j)));
            display(y1);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%integrate the randomness for all the random distributed lambda%
%pos(1,2);
   Pen=dblquad(@pos,0,1.5,0,1.5);
   display(Pen);
   
   e = cputime-t;
   display(e); 
end
