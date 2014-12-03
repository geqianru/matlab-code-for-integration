function [heapopt, heapLCC, D_0] = heurapp(n)
t = cputime; 
T = 10; % service period according to the service contract
ed_f = 1; % penalty level for the penalty cost
N = 30;   % the largest number of instance
a1 = 10000; %parameter for the acquisition costs
for i = 1:30 % index for the compoents 
    for j = 1:2 % index for the design for each component 
        CA(i,j) = (1./j) * (a1-(i-1) * 325); % acquisition cost for each design for each component
    end
end
% repair cost for design 1 of all the components
CR(:,1) = [500,	967.5,	1870, 451.25, 870,	1675, 402.5, 772.5,	1480, 353.75, 675, 1285, 305, 577.5, 1090,	256.25,	480, 895, 207.5, 382.5,	700, 158.75, 285, 505,	110, 187.5,	310, 61.25,	90,	115];
% repair cost for design 2 of all the components
CR(:,2) = 0.5 * CR(:,1);
%single repair time for design 1 of all the components
R(:,1) = [12,32, 28, 10, 41, 5,	11,	12,	12,	8,	20,	34,	31,	8,	16,	41,	47,	33,	9,	19, 33,	46,	5, 37, 21, 6, 34, 13, 32, 33];
%single repair time for design 2 of all the components
R(:,2) = [32,25,16,	35,	14,	25,	27,	38,	2,	23,	15,	4,	9,	21,	10,	15,	17,	27,	27,	33, 9, 30, 19, 30, 9, 37, 26, 8, 3,	25];
% expected value of lambda for design 1 of all the components 
Mu(:,1) = [0.23, 0.17,	0.15, 0.25,	0.14, 0.25,	0.21, 0.24,	0.14, 0.29,	0.14, 0.21,	0.20, 0.26,	0.29, 0.16,	0.18, 0.27,	0.16, 0.20, 0.25, 0.12,	0.11, 0.13,	0.28, 0.19,	0.14, 0.28,	0.25, 0.27];
% expected value of lambda for design 2 of all the components
Mu(:,2) = [0.47, 0.41,	0.45, 0.60,	0.46, 0.51,	0.53, 0.55,	0.54, 0.52,	0.55, 0.46,	0.53, 0.57,	0.58, 0.42,	0.44, 0.51,	0.50, 0.45, 0.54, 0.43,	0.48, 0.44,	0.53, 0.57,	0.42, 0.55,	0.47, 0.56];
% standard deviation of lambda for design 1 of all the components
Sigma(:,1) = [0.05,	0.06, 0.07,	0.05, 0.05,	0.12, 0.04,	0.08, 0.07,	0.06, 0.05,	0.11, 0.04,	0.09, 0.14,	0.03, 0.06,	0.13, 0.03, 0.07, 0.12,	0.02, 0.04,	0.07, 0.06,	0.07, 0.07,	0.06, 0.09,	0.13];
% standard deviation of lambda for design 2 of all the components
Sigma(:,2) = [0.17,	0.20, 0.09,	0.21, 0.23,	0.10, 0.18,	0.27, 0.11,	0.18, 0.27,	0.09, 0.18,	0.29, 0.12,	0.15, 0.22,	0.10, 0.18,	0.23, 0.11,	0.15, 0.24,	0.09, 0.19,	0.28, 0.08,	0.19, 0.23,	0.11];    
%%%Compute D_0
TD_0 = 0.5.*(Mu(:,1) .* R(:,1) + Mu(:,2) .* R(:,2)).*T * ed_f; %Array of D_0 for all 30 components

% cut the empty entry in the vector of D_0
for i = 1: N-n
    TD_0(length(TD_0))=[];
end

D_0 = sum(TD_0);%Targeted downtime

%inital point of the local search
for i = 1:n
    initial(i) =  
end