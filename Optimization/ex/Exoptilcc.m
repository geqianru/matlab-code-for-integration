function [ExminLCC,Opts,e,D_0, Num_opts] = Exoptilcc(n)
t = cputime; 
T = 10; % service period according to the service contract
ed_f = 1; % penalty level for the penalty cost
N = 10;   % the largest number of instance
%~~~~~~~~~~~~~~Parameter setting for the original design~~~~(start)~~ 
% a1 = 10000; %parameter for the acquisition costs
% for i = 1:30 % index for the compoents 
%     for j = 1:2 % index for the design for each component 
%         CA(i,j) = (1./j) * (a1-(i-1) * 325); % acquisition cost for each design for each component
%     end
% end
% % repair cost for design 1 of all the components
% CR(:,1) = [500,	967.5,	1870, 451.25, 870,	1675, 402.5, 772.5,	1480, 353.75, 675, 1285, 305, 577.5, 1090,	256.25,	480, 895, 207.5, 382.5,	700, 158.75, 285, 505,	110, 187.5,	310, 61.25,	90,	115];
% % repair cost for design 2 of all the components
% CR(:,2) = 0.5 * CR(:,1);
% %single repair time for design 1 of all the components
% R(:,1) = [12,32, 28, 10, 41, 5,	11,	12,	12,	8,	20,	34,	31,	8,	16,	41,	47,	33,	9,	19, 33,	46,	5, 37, 21, 6, 34, 13, 32, 33];
% %single repair time for design 2 of all the components
% R(:,2) = [32,25,16,	35,	14,	25,	27,	38,	2,	23,	15,	4,	9,	21,	10,	15,	17,	27,	27,	33, 9, 30, 19, 30, 9, 37, 26, 8, 3,	25];
% % expected value of lambda for design 1 of all the components 
% Mu(:,1) = [0.23, 0.17,	0.15, 0.25,	0.14, 0.25,	0.21, 0.24,	0.14, 0.29,	0.14, 0.21,	0.20, 0.26,	0.29, 0.16,	0.18, 0.27,	0.16, 0.20, 0.25, 0.12,	0.11, 0.13,	0.28, 0.19,	0.14, 0.28,	0.25, 0.27];
% % expected value of lambda for design 2 of all the components
% Mu(:,2) = [0.47, 0.41,	0.45, 0.60,	0.46, 0.51,	0.53, 0.55,	0.54, 0.52,	0.55, 0.46,	0.53, 0.57,	0.58, 0.42,	0.44, 0.51,	0.50, 0.45, 0.54, 0.43,	0.48, 0.44,	0.53, 0.57,	0.42, 0.55,	0.47, 0.56];
% % standard deviation of lambda for design 1 of all the components
% Sigma(:,1) = [0.05,	0.06, 0.07,	0.05, 0.05,	0.12, 0.04,	0.08, 0.07,	0.06, 0.05,	0.11, 0.04,	0.09, 0.14,	0.03, 0.06,	0.13, 0.03, 0.07, 0.12,	0.02, 0.04,	0.07, 0.06,	0.07, 0.07,	0.06, 0.09,	0.13];
% % standard deviation of lambda for design 2 of all the components
% Sigma(:,2) = [0.17,	0.20, 0.09,	0.21, 0.23,	0.10, 0.18,	0.27, 0.11,	0.18, 0.27,	0.09, 0.18,	0.29, 0.12,	0.15, 0.22,	0.10, 0.18,	0.23, 0.11,	0.15, 0.24,	0.09, 0.19,	0.28, 0.08,	0.19, 0.23,	0.11];    
%~~~~~~~~~~~~~~Parameter setting for the original design~~~~(end)~~
 
%~~~~~~~~~~~~Parameter setting for the 1st design~~~~~~~~~(Start)~~~~~~
% CA(:,1) = [500	1000	1500	2000	2500	3000	3500	4000	4500	5000];
% CA(:,2) = 2*[500	1000	1500	2000	2500	3000	3500	4000	4500	5000];
% CR(:,1) = [100 400	450	400	1000	900	700	1600	1350	1000];
% CR(:,2) = [300	400	1200	1200	1000	2400	2100 1600 3600 3000];
% R(:,1) = [1	3 5	2	4	1	3	5	2	4];
% R(:,2) = [2	4 1	3	5	2	4	1	3	5];
% Mu(:,1) = [0.43	0.91 0.19 0.27 0.15	0.14 0.87 0.58 0.55 0.15];
% Mu(:,2) = [0.85	0.62 0.35 0.51 0.4	0.08  0.24	0.13 0.19 0.24];
% Sigma(:,1) = [0.0645 0.2275	0.0665	0.1215 0.0825 0.014	0.174 0.174	0.22 0.075];
% Sigma(:,2) = [0.085	0.124 0.105	0.204	0.2	0.048	0.036	0.0325	0.0665	0.108];
%~~~~~~~~~~~~Parameter setting for the 1st design~~~~~~~~~(End)~~~~~~

%~~~~~~~~~~~~Parameter setting for the 2nd design~~~~~~~~~(Start)~~~~~~
% CA(:,1) = [500	1000	1500	2000	2500	3000	3500	4000	4500	5000];
% CA(:,2) = 2*[500	1000	1500	2000	2500	3000	3500	4000	4500	5000];
% CR(:,1) = [100 400	450	400	1000	900	700	1600	1350	1000];
% CR(:,2) = [300	400	1200	1200	1000	2400	2100 1600 3600 3000];
% R(:,1) = [1	3 5	2	4	1	3	5	2	4];
% R(:,2) = [2	4 1	3	5	2	4	1	3	5];
% Mu(:,1) = [0.20	0.40 0.60 0.10 0.30 0.50 0.70 0.20 0.40 0.60];
% Mu(:,2) = [0.10	0.30 0.50 0.70 0.20	0.40 0.60 0.10	0.30 0.50];
% Sigma(:,1) = [0.03	0.10 0.21 0.05 0.17	0.05 0.14 0.06 0.16 0.30];
% Sigma(:,2) = [0.01 0.06	0.15 0.28 0.10 0.24	0.09 0.03 0.11 0.23];
%~~~~~~~~~~~~Parameter setting for the 2nd design~~~~~~~~~(End)~~~~~~

%~~~~~~~~~~~~Parameter setting for the 3rd design~~~~~~~~~(Start)~~~~~~
% CA(:,1) = [500	1000	1500	2000	2500	3000	3500	4000	4500	5000];
% CA(:,2) = 2*[500	1000	1500	2000	2500	3000	3500	4000	4500	5000];
% CR(:,1) = [100 400	450	400	1000	900	700	1600	1350	1000];
% CR(:,2) = [300	400	1200	1200	1000	2400	2100 1600 3600 3000];
% R(:,1) = [1	3 5	2	4	1	3	5	2	4];
% R(:,2) = [2	4 1	3	5	2	4	1	3	5];
% Mu(:,1) = [0.20	0.40 0.60 0.10 0.30 0.50 0.70 0.20 0.40 0.60];
% Mu(:,2) = [0.10	0.30 0.50 0.70 0.20	0.40 0.60 0.10	0.30 0.50];
% Sigma(:,1) = [0.06 0.20	0.42 0.09	0.33	0.10	0.28	0.12	0.32	0.60];
% Sigma(:,2) = [0.02 0.12	0.30 0.56	0.20	0.48	0.18	0.05 0.21 0.45];
%~~~~~~~~~~~~Parameter setting for the 3rd design~~~~~~~~~(End)~~~~~~

%~~~~~~~~~~~~Parameter setting for the 4th design~~~~~~~~~(Start)~~~~~~
CA(:,1) = [500	1000	1500	2000	2500	3000	3500	4000	4500	5000];
CA(:,2) = 2*[500	1000	1500	2000	2500	3000	3500	4000	4500	5000];
CR(:,1) = [100 400	450	400	1000	900	700	1600	1350	1000];
CR(:,2) = [300	400	1200	1200	1000	2400	2100 1600 3600 3000];
R(:,1) = [1	3 5	2	4	1	3	5	2	4];
R(:,2) = [2	4 1	3	5	2	4	1	3	5];
Mu(:,1) = [0.40	0.80	1.20	0.20	0.60	1.00	1.40	0.40	0.80 1.20];
Mu(:,2) = [0.20	0.60	1.00	1.40	0.40	0.80	1.20	0.20	0.60	1.00];
Sigma(:,1) = [0.12	0.40	0.84	0.18	0.66	0.20	0.56	0.24	0.64	1.20];
Sigma(:,2) = [0.04	0.24	0.60	1.12	0.40	0.96	0.36	0.10	0.42	0.90];
%~~~~~~~~~~~~Parameter setting for the 4th design~~~~~~~~~(End)~~~~~~

%%%Compute D_0
TD_0 = 0.5.*(Mu(:,1) .* R(:,1) + Mu(:,2) .* R(:,2)).*T * ed_f; %Array of D_0 for all 30 components

% cut the empty entry in the vector of D_0
for i = 1: N-n
    TD_0(length(TD_0))=[];
end

D_0 = sum(TD_0);%Targeted downtime

% transfer the Decimal index of each policy into a Binary index of each
% policy
    function L = bits(x,n)
        for i = 1:n
            L(i) = mod(floor(x./2^(i-1)),2);
        end
    end
ExminLCC = Inf;
opts = zeros(length(n), 1); % create the vector for the optimal policy
for i = 1:2^n  % the decimal index for a policy from 1 to 2^n
    S = bits(i-1,n); % the binary index for a policy from 1 to 2^n
    %display(S);
    for j = 1:n % the value for each entry of a given policy vector
        c_a(j) = CA(j,S(j)+1); % set the value of the acquisition cost for each design of a given component, 
                               % s(j) can either be 0 or 1, if s(j)=0, its the value for design 1, otherwise, design 2.  
        c_r(j) = CR(j,S(j)+1); % set the value of the repair cost for each design of a given component, 
        r(j) = R(j,S(j)+1);    % set the value of the repair time for each design of a given component, 
        mu(j) = Mu(j,S(j)+1);  % set the expected value of lambda for each design of a given component,
        sigma(j) = Sigma(j,S(j)+1); % set the standard deviation value of lambda for each design of a given component,
    end
   ExLCCosts = ExLCC(c_a,c_r,r,mu,D_0); % compute the Life cycle cost for each given policy
   if (ExLCCosts < ExminLCC) % if the new policy is smaller than the previous one, 
       ExminLCC = ExLCCosts; % save it as the optimal(minimized) LCC
       opts = S;             % and the optimal design
   end      
end

%display(minLCC)
%display(opts);

%display(e);

%transfer the optimal policy to a decimal number which is eaier for further
%comparison
Num_opts = 0;
   for m = 1 : length(opts)
       Num_opts = Num_opts + opts(m).* 2^(m-1);
   end

Opts = [opts, zeros(1,N-n)]; %extend the vector of the optimal policy to a N dimision vector for saving convinience
e = cputime-t;
end