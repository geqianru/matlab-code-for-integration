function [inte]=MC(mu_1,mu_2,mu_3,mu_4,mu_5,mu_6,mu_7,mu_8,mu_9,mu_10,mu_11,mu_12)
t = cputime; 
sigma_1=0.4*mu_1;
sigma_2=0.4*mu_2;
sigma_3=0.4*mu_3;
sigma_4=0.4*mu_4;
sigma_5=0.4*mu_5;
sigma_6=0.4*mu_6;
sigma_7=0.4*mu_7;
sigma_8=0.4*mu_8;
sigma_9=0.4*mu_9;
sigma_10=0.4*mu_10;
sigma_11=0.4*mu_11;
sigma_12=0.4*mu_12;
% sigma_3=0.4*mu_3;
% sigma_3=0.4*mu_3;
% mu=[mu_1,mu_2,mu_3];
% sigma=[sigma_1,sigma_2,sigma_3];
u_1=mu_1+3.*sigma_1;
u_2=mu_1+3.*sigma_2;
u_3=mu_1+3.*sigma_3;
u_4=mu_1+3.*sigma_4;
u_5=mu_1+3.*sigma_5;
u_6=mu_1+3.*sigma_6;
u_7=mu_1+3.*sigma_7;
u_8=mu_1+3.*sigma_8;
u_9=mu_1+3.*sigma_9;
u_10=mu_1+3.*sigma_10;
u_11=mu_1+3.*sigma_11;
u_12=mu_1+3.*sigma_12;
l_1=0;
l_2=0;
l_3=0;
l_4=0;
l_5=0;
l_6=0;
l_7=0;
l_8=0;
l_9=0;
l_10=0;
l_11=0;
l_12=0;
% u=[u_1,u_2,u_3];
% l=[l_1,l_2,l_3];
% x=l+rand(100,1).*(u-l);
samples = 300000;
x_1=l_1+rand(samples,1)*(u_1-l_1);
x_2=l_2+rand(samples,1)*(u_2-l_2);
x_3=l_3+rand(samples,1)*(u_3-l_3);
x_4=l_4+rand(samples,1)*(u_4-l_4);
x_5=l_5+rand(samples,1)*(u_5-l_5);
x_6=l_6+rand(samples,1)*(u_6-l_6);
x_7=l_7+rand(samples,1)*(u_7-l_7);
x_8=l_8+rand(samples,1)*(u_8-l_8);
x_9=l_9+rand(samples,1)*(u_9-l_9);
x_10=l_10+rand(samples,1)*(u_10-l_10);
x_11=l_11+rand(samples,1)*(u_11-l_11);
x_12=l_12+rand(samples,1)*(u_12-l_12);
% x_3=l_3+rand(100,1)*(u_3-l_3);

T=10;
C_p=3000;
r=1;
D_0=12;

% display(x_1);
% display(x_2);
x=x_1+x_2+x_3+x_4+x_5+x_6+x_7+x_8+x_9+x_10+x_11+x_12;
Nor=normpdf(x_1,mu_1,sigma_1).*normpdf(x_2,mu_2,sigma_2).*normpdf(x_3,mu_3,sigma_3).*normpdf(x_4,mu_4,sigma_4).*normpdf(x_5,mu_5,sigma_5).*normpdf(x_6,mu_6,sigma_6).*normpdf(x_7,mu_7,sigma_7).*normpdf(x_8,mu_8,sigma_8).*normpdf(x_9,mu_9,sigma_9).*normpdf(x_10,mu_10,sigma_10).*normpdf(x_11,mu_11,sigma_11).*normpdf(x_12,mu_12,sigma_12);
Bound=(u_1-l_1).*(u_2-l_2).*(u_3-l_3).*(u_4-l_4).*(u_5-l_5).*(u_6-l_6).*(u_7-l_7).*(u_8-l_8).*(u_9-l_9).*(u_10-l_10).*(u_11-l_11).*(u_12-l_12);
display(1);
inte_sum = 0;
  
for n = [ceil(D_0/r):1:80]
    intes(n+1) = sum(poisspdf(n,x.*T).*Nor)/samples.*Bound.*(n.*r-D_0).*C_p;
    
end
%display(intes);
MC=sum(intes);
 e = cputime-t;
display(e);
display(MC);
% plot([0:1:31],intes)




% nor_3=normpdf(x_3,mu_3,sigma_3);
% inte=(sum(poisspdf(n,(x_1+x_2+x_3).*T).*nor_1.*nor_2.*nor_3.*(u_1-l_1).*(u_2-l_2).*(u_3-l_3))/10000).*(n.*r-D_0);
% inte=zeros(31,31);
% for x_1 = [0:0.1:3]
%     for x_2 = [0:0.1:3]
%         %x_1 = (i_1 - 1)/10
%         %x_2 = (i_2 - 1)/10
%         i_1 = floor(x_1 * 10 + 1)
%         i_2 = floor(x_2 * 10 + 1)
%         inte(i_1,i_2)=poisspdf(n,(x_1+x_2).*T).*normpdf(x_1,mu_1,sigma_1).*normpdf(x_2,mu_2,sigma_2);
%     end
% end
% x_1 = [0:0.1:3]
% x_2 = [0:0.1:3]
% surf(x_1,x_2,inte);
end


















