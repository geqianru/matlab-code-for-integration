%traditional way of computing penalty cost%
function[Pen]=Pendown(mu_1,mu_2,r_1,r_2)
t = cputime;
T=10;
D_0=(mu_1+mu_2)*10.*1.5;
sigma_1=mu_1.*0.4;
sigma_2=mu_2.*0.4;
c_p=72000;
%inside integral%
 function ii=yi(lambda_1,lambda_2,i,j)
          ii=poisspdf(i-1,lambda_1.*T).*poisspdf(j-1,lambda_2.*T).*normpdf(lambda_1,mu_1,sigma_1).*normpdf(lambda_2,mu_2,sigma_2);
 end


%integrate the randomness for all the random distributed lambda%

    function ran=ra(i,j)
        f=@(lambda_1,lambda_2)yi(lambda_1,lambda_2,i,j);
        ran=integral2(f,0,5,0,5);
        display(ran);
    end
        

% %integrate the randomness for all the random distributed lambda%
%     function y=in(i,j)
%      for m=[1:50]
%            t(m)=(m-1).*0.1;
%         for n=[1:50]
%             q(n)=(n-1).*0.1;
%           display([t(m),q(n)]);
%           P(m,n)=yi(t(m),q(n));
%           display(P(m,n));
%         end
%      end
%      P(m,n)=yi(t(m),q(n));
%      y=trapz(m,n,P);
%      display(y);
%     end

%convolution for the possion part%
Pend = zeros(30,30); 
 for i = [1:30]
            for j = [1:30]
                Downtime(i,j)=(i-1).*r_1+(j-1).*r_2;
                display(i);
                display(j);
                display(Downtime(i,j));
                Pend(i,j)=ra(i-1,j-1).*max(0,Downtime(i,j)-D_0).*c_p;
                display(Pend(i,j));
            end
 end
                
%Pen=sum(sum(P));
Pen=sum(sum(Pend));
e = cputime-t;
display(Pen);
display(e); 
end
