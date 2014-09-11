function [downtime] = Gammalognormal(mu,r)
T = 10;
%D_0 = mu * r * T;
sigma = mu * 0.4;
M_21 = (T^2) * (r^2) * (mu^2+sigma^2);
M_1 = mu * T * r;
M_23 = mu * T * r^2;
M_2 = M_21 + M_23;
theta = M_2 / M_1 - M_1;
k = M_1 / theta;
x_1 = gaminv((0.005:0.01:0.995),k,theta);
y_1 = gampdf(x_1,k,theta);
plot(x_1,y_1,'r');
end