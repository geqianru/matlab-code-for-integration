function [inte]= QMC(mu_1,mu_2,r_1,r_2)
%mu_4,mu_5,mu_6,mu_7,mu_8,mu_9,mu_10,mu_11,mu_12)

t = cputime; 

%disp('test')


%disp('test2')
sigma_1=0.4*mu_1;
sigma_2=0.4*mu_2;
%sigma_3=0.4*mu_3;
% sigma_4=0.4*mu_4;
% sigma_5=0.4*mu_5;
% sigma_6=0.4*mu_6;
% sigma_7=0.4*mu_7;
% sigma_8=0.4*mu_8;
% sigma_9=0.4*mu_9;
% sigma_10=0.4*mu_10;
% sigma_11=0.4*mu_11;
% sigma_12=0.4*mu_12;
% mu=[mu_1,mu_2,mu_3];
% sigma=[sigma_1,sigma_2,sigma_3];
u_1=mu_1+3.*sigma_1;
u_2=mu_1+3.*sigma_2;
%u_3=mu_1+3.*sigma_3;
% u_4=mu_1+3.*sigma_4;
% u_5=mu_1+3.*sigma_5;
% u_6=mu_1+3.*sigma_6;
% u_7=mu_1+3.*sigma_7;
% u_8=mu_1+3.*sigma_8;
% u_9=mu_1+3.*sigma_9;
% u_10=mu_1+3.*sigma_10;
% u_11=mu_1+3.*sigma_11;
% u_12=mu_1+3.*sigma_12;
l_1=0;
l_2=0;
%l_3=0;
% l_4=0;
% l_5=0;
% l_6=0;
% l_7=0;
% l_8=0;
% l_9=0;
% l_10=0;
% l_11=0;
% l_12=0;
% u=[u_1,u_2,u_3];
% l=[l_1,l_2,l_3];
% x=l+rand(100,1).*(u-l);
samples = 300000;
p=haltonset(3,'Skip',2e3);
%display(p(1:10,1:10));
%p = scramble(p,'RR2');
X0=net(p,samples);
%X0= p(1:3:samples,:)
%   x_1=l_1+rand(samples,1)*(u_1-l_1);
%   x_2=l_2+rand(samples,1)*(u_2-l_2);
% x_3=l_3+rand(samples,1)*(u_3-l_3);
% x_3=l_3+rand(100,1)*(u_3-l_3);
% p = haltonset(1,'Skip',1e5,'Leap', 314);
% x_1=l_1+p(1:3:samples*3+1)*(u_1-l_1);
% x_2=l_2+p(2:3:samples*3+2)*(u_2-l_2);
lambda_1=l_1+X0(:,1)*(u_1-l_1);
lambda_2=l_2+X0(:,2)*(u_2-l_2);
%x_3=l_3+X0(:,3)*(u_3-l_3);
% x_4=l_4+X0(:,4)*(u_4-l_4);
% x_5=l_5+X0(:,5)*(u_5-l_5);
% x_6=l_6+X0(:,6)*(u_6-l_6);
% x_7=l_7+X0(:,7)*(u_7-l_7);
% x_8=l_8+X0(:,8)*(u_8-l_8);
% x_9=l_9+X0(:,9)*(u_9-l_9);
% x_10=l_10+X0(:,10)*(u_10-l_10);
% x_11=l_11+X0(:,11)*(u_11-l_11);
% x_12=l_12+X0(:,12)*(u_12-l_12);
%  x_3=p(3:3:samples);

T=10;
C_p=72000;
%r=1;
D_0=(mu_1+mu_2)*10.*1.5;
% x=lambda_1+lambda_2;
% +x_4+x_5+x_6+x_7+x_8+x_9+x_10+x_11+x_12;
% Nor=normpdf(lambda_1,mu_1,sigma_1).*normpdf(lambda_2,mu_2,sigma_2);

%.*normpdf(x_3,mu_3,sigma_3);
% .*normpdf(x_4,mu_4,sigma_4).*normpdf(x_5,mu_5,sigma_5).*normpdf(x_6,mu_6,sigma_6).*normpdf(x_7,mu_7,sigma_7).*normpdf(x_8,mu_8,sigma_8).*normpdf(x_9,mu_9,sigma_9).*normpdf(x_10,mu_10,sigma_10).*normpdf(x_11,mu_11,sigma_11).*normpdf(x_12,mu_12,sigma_12);
Bound=(u_1-l_1).*(u_2-l_2);
%.*(u_3-l_3);
% .*(u_4-l_4).*(u_5-l_5).*(u_6-l_6).*(u_7-l_7).*(u_8-l_8).*(u_9-l_9).*(u_10-l_10).*(u_11-l_11).*(u_12-l_12);
display(1);
%display(x_2);

% inte_sum = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inside integral%%%%%%%%%%%%%%%%%
 function ii=yi(lambda_1,lambda_2,i,j)
          ii=poisspdf(i,lambda_1.*T).*poisspdf(j,lambda_2.*T).*normpdf(lambda_1,mu_1,sigma_1).*normpdf(lambda_2,mu_2,sigma_2);
 end

intes=zeros(30,30);
for i=1:30
    for j=1:30
        Downtime(i,j)=(i-1).*r_1+(j-1).*r_2;
        display(i);
        display(j);
        display(Downtime(i,j));
        intes(i,j) = sum(poisspdf(i-1,lambda_1.*T).*poisspdf(j-1,lambda_2.*T).*Nor)/samples.*Bound.*max(0,Downtime(i,j)-D_0).*c_p;
end
 
%display(intes);
QMC=sum(intes);
 e = cputime-t;
display(e); 
display(QMC);
end


% 
% function hn = localHaltonSingleNumber(n,b)
% % This function generates the n-th number in Halton's low
% % discrepancy sequence.
% 
% n0 = n;
% hn = 0;
% f = 1/b;
% while (n0>0)
%     n1 = floor(n0/b);
%     r = n0-n1*b;
%     hn = hn + f*r;
%     f = f/b;
%     n0 = n1;
% end 