function[Pen]= PenErlang(mu_1,mu_2,r_1,r_2)
t = cputime; 
T=10;
D_0=(mu_1+mu_2)*10-1;
c_p=72000;
s_1=mu_1.*T.*r_1;
s_2=mu_2.*T.*r_2;
display(sum(s_1+s_2));
%s_3=Lambda_3.*T.*r_3;
v_1=mu_1.*T.*r_1^2;
v_2=mu_2.*T.*r_2^2;
%v_3=Lambda_3.*T.*r_3^2;
theta=sum(v_1+v_2)./sum(s_1+s_2);
display(theta);
k=(sum(s_1+s_2))^2./sum(v_1+v_2);
display(k);