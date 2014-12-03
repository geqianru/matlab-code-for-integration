function [LocsminLCC, Opts,e,D_0,Num_opts] = locsearchLCC(n)
% solve the given problem using local search method
t = cputime;
T = 10;
ed_f = 1;
N = 30;
a1 = 10000;
for i = 1:30
    for j = 1:2
        CA(i,j) = (1./j) * (a1-(i-1) * 325);
    end
end
CR(:,1) = [500,	967.5,	1870, 451.25, 870,	1675, 402.5, 772.5,	1480, 353.75, 675, 1285, 305, 577.5, 1090,	256.25,	480, 895, 207.5, 382.5,	700, 158.75, 285, 505,	110, 187.5,	310, 61.25,	90,	115];
CR(:,2) = 0.5 * CR(:,1);
R(:,1) = [12,32, 28, 10, 41, 5,	11,	12,	12,	8,	20,	34,	31,	8,	16,	41,	47,	33,	9,	19, 33,	46,	5, 37, 21, 6, 34, 13, 32, 33];
R(:,2) = [32,25,16,	35,	14,	25,	27,	38,	2,	23,	15,	4,	9,	21,	10,	15,	17,	27,	27,	33, 9, 30, 19, 30, 9, 37, 26, 8, 3,	25];
Mu(:,1) = [0.23, 0.17,	0.15, 0.25,	0.14, 0.25,	0.21, 0.24,	0.14, 0.29,	0.14, 0.21,	0.20, 0.26,	0.29, 0.16,	0.18, 0.27,	0.16, 0.20, 0.25, 0.12,	0.11, 0.13,	0.28, 0.19,	0.14, 0.28,	0.25, 0.27];
Mu(:,2) = [0.47, 0.41,	0.45, 0.60,	0.46, 0.51,	0.53, 0.55,	0.54, 0.52,	0.55, 0.46,	0.53, 0.57,	0.58, 0.42,	0.44, 0.51,	0.50, 0.45, 0.54, 0.43,	0.48, 0.44,	0.53, 0.57,	0.42, 0.55,	0.47, 0.56];
Sigma(:,1) = [0.05,	0.06, 0.07,	0.05, 0.05,	0.12, 0.04,	0.08, 0.07,	0.06, 0.05,	0.11, 0.04,	0.09, 0.14,	0.03, 0.06,	0.13, 0.03, 0.07, 0.12,	0.02, 0.04,	0.07, 0.06,	0.07, 0.07,	0.06, 0.09,	0.13];
Sigma(:,2) = [0.17,	0.20, 0.09,	0.21, 0.23,	0.10, 0.18,	0.27, 0.11,	0.18, 0.27,	0.09, 0.18,	0.29, 0.12,	0.15, 0.22,	0.10, 0.18,	0.23, 0.11,	0.15, 0.24,	0.09, 0.19,	0.28, 0.08,	0.19, 0.23,	0.11];    
%%%Compute D_0
TD_0 = 0.5.*(Mu(:,1) .* R(:,1) + Mu(:,2) .* R(:,2)).*T * ed_f; %Array of D_0 for all 30 components
for i = 1: N-n
    TD_0(length(TD_0))=[];
end
D_0 = sum(TD_0);%Targeted downtime
% Set the initial point of local search
% According to the results from enumeration, the initial point is set as:
% the policy selecting the second design for all the compoents.
opts = zeros(n,1); % initial value of the optimal policy according to the initial solution 
display(opts);
%k = 1;
for j = 1:n
    c_a(j) = CA(j,2); % set c_a for each component, which is the second raw of CA
    c_r(j) = CR(j,2); % set c_r for each component, which is the second raw of CR 
    r(j) = R(j, 2);  % set c_r for each component, which is the second raw of CR 
    mu(j) = Mu(j, 2); % set mu for each component, which is the second raw of Mu
    sigma(j) = Sigma(j, 2); % set sigma for each component, which is the second raw of Sigma
end
minLCCosts = LCC(c_a,c_r,r,mu,sigma,D_0); %the Life cycle costs of the initial policy & the initial value of the minimum LCC
display (minLCCosts);
Searchno =  randi([1 n-1],1,2); % choose two random numbers as the distances of the neighborhood of the initial solution
% find the optimal solution in the first neighborhood: (the distance is the first random number)
v = 1:1:n; 
combi1 = nchoosek(v,Searchno(1)); % gives all possible combinations of the elements of vector v taken k at a time
                        %(the structure of the first neighborhood)
% the number of the solution in the first neighborhood
   for i = 1 : length(combi1)
       feapoli = ones(n,1);
       %oppositefeapoli = zeros(n,1); % set the initial value of the opposite selection of every policy
       for j = 1 : Searchno(1)
       feapoli(combi1(i,j)) = 0; % find the first position in the feasible plolicy in the first neighorhood which is different from the initial solution
       end                                  % set the value of this position to be 1
       display(feapoli);
       for k = 1 : n   % set the c_a, c_r, r and etc values for each feasible policy in the neighorhood 
           c_a(j) = CA(j,feapoli(k)+1);
           c_r(j) = CR(j,feapoli(k)+1);
           r(j) = R(j,feapoli(k)+1);
           mu(j) = Mu(j,feapoli(k)+1);
           sigma(j) = Sigma(j,feapoli(k)+1);
       end
       feapoliLCC = LCC(c_a,c_r,r,mu,sigma,D_0); % get the LCC for each given feasible policy
       if (feapoliLCC < minLCCosts) % compare the feasible solution with the current solution
       minLCCosts = feapoliLCC;
       opts = feapoli;
       end 
   end
   display(opts);
   display(minLCCosts)
        
end
