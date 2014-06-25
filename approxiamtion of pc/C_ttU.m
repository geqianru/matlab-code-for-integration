% total costs, objective function for uniform distribution of lambda%
function [y]=C_ttU(a_1,b_1,a_2,b_2,r)
t = cputime;
T = 10;                              %period of service contract% 
mu_1 = 0.5 * (a_1 + b_1);
mu_2 = 0.5 * (a_2 + b_2);
pdf_1 = 1/(b_1-a_1);
pdf_2 = 1/(b_2-a_2);
D_0 = (mu_1+mu_2)*10-1;              %predetermined total downtime of a service contract%                                            
c_p = 72000;                         %penalty cost when downtime exceeds predetermined level%
n = ceil(D_0/r);                     %downtime times%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inside part of the integral of probability%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   function ii=yi(lambda_1,lambda_2,n)
            ii=poisspdf(n,(lambda_1+lambda_2).*T).*pdf_1.*pdf_2;    
   end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%integral of the probability%%%%%%%
%    function y=in(n)
%             i=1;
%             t(i)=0.1;
%                while(t(i)<50)
%                     R2(i)=yi(t(i));
%                     t(i+1)=t(i)+0.1;
%                     i=i+1;
%                end
%             R2(i)=yi(t(i));
%             y=trapz(t,R2); 
%    end

Q=dblquad(@yi,a_1,b_1,a_2,b_2);


y_4=in(n).*(n.*r-D_0).*c_p;
    while (n<=50)
           y_3=y_4;
           n=n+1;  
           y_4=y_3+in(n).*(n.*r-D_0).*c_p;
    end
   
y_4=y_3+in(n).*(n.*r-D_0).*c_p;       
y=y_4;
e=cputime-t;
display(y);
%display(e);

end