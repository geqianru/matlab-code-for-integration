% partial enumeration results under the parameter setting of design 1
function [minLCCosts,Opp,e,D_0,Num_opps]= partialenumeration2(n,Oppn)
t = cputime;
T = 10;
ed_f = 1;
N = 10;
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
% Sigma(:,1) = [0.06 0.20	0.42	0.09	0.33	0.10	0.28	0.12	0.32	0.60];
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
Sigma(:,1) = [0.12	0.40 0.84	0.18	0.66	0.20	0.56	0.24	0.64	1.20];
Sigma(:,2) = [0.04	0.24	0.60	1.12	0.40	0.96	0.36	0.10	0.42	0.90];
%~~~~~~~~~~~~Parameter setting for the 4th design~~~~~~~~~(End)~~~~~~

%%%Compute D_0
TD_0 = 0.5.*(Mu(:,1) .* R(:,1) + Mu(:,2) .* R(:,2)).*T * ed_f; %Array of D_0 for all 30 componentsend
for i = 1: N-n
    TD_0(length(TD_0))=[];
end
D_0 = sum(TD_0);%Targeted downtime

% Cut the last several entries of Oppn so that the dimension of Oppn is
% n-1.
for i = 1: N-n+1
    Oppn(length(Oppn))=[];
end
   opts1 = [Oppn 0]; % Start the first partial enumeration round by setting intial optimal policy as the optimal solution 
                     % for the last policy , enumerate it with 0 and 1.
   display (opts1); 
    for j = 1:n
        c_a(j) = CA(j,opts1(j)+1); % set c_a for each component, which is the second raw of CA
        c_r(j) = CR(j,opts1(j)+1); % set c_r for each component, which is the second raw of CR 
        r(j) = R(j, opts1(j)+1);  % set c_r for each component, which is the second raw of CR 
        mu(j) = Mu(j, opts1(j)+1); % set mu for each component, which is the second raw of Mu
        sigma(j) = Sigma(j, opts1(j)+1); % set sigma for each component, which is the second raw of Sigma
    end
    display(c_a);
   minLCCosts = LCC(c_a,c_r,r,mu,sigma,D_0);
   display(minLCCosts);
   opp = opts1; 
    for m = 1 : n-1  % first find the optimal policy under the condition that the nth policy = 0 and only one policy are
                     % changed from  the optimal policy for the n-1 case. 
        feapo_11(m,:) = opts1; 
        feapo_11(m,m) = mod(opts1(m) + 1, 2);
        display(feapo_11(m,:));
        for j = 1:n
            c_a(j) = CA(j,feapo_11(m,j)+1); % set c_a for each component, which is the second raw of CA
            c_r(j) = CR(j,feapo_11(m,j)+1); % set c_r for each component, which is the second raw of CR 
            r(j) = R(j, feapo_11(m,j)+1);  % set c_r for each component, which is the second raw of CR
            mu(j) = Mu(j, feapo_11(m,j)+1); % set mu for each component, which is the second raw of Mu
            sigma(j) = Sigma(j, feapo_11(m,j)+1); % set sigma for each component, which is the second raw of Sigma
        end
        display (c_a);
        feapoLCC_11(m) = LCC(c_a,c_r,r,mu,sigma,D_0);
        display(feapoLCC_11(m));
        if(feapoLCC_11(m) < minLCCosts)
            minLCCosts = feapoLCC_11(m);
            display (minLCCosts);
            opp = feapo_11(m,:);
            display (opp)
        end
    end
    
% start searching for the optimal solution under the condition that the nth policy = 1, only two 
% policy are different from the optimal n-1 policy
  v = 1:1:n-1; 
  combi = nchoosek(v,2); % returns a matrix containing all possible combinations of the elements of vector v taken 2 
                         % at a time
  for m = 1:nchoosek(n-1, 2)  % second find the optimal solution among solutions where nth policy = 0 and two policies are
                            % changed from  the optimal policy for the n-1 case. 
     feapo_12(m,:) = opts1;
     feapo_12(m, combi(m, 1)) = mod(opts1(combi(m, 1)) + 1, 2);
     feapo_12(m, combi(m, 2)) = mod(opts1(combi(m, 2)) + 1, 2);
       for j = 1:n
            c_a(j) = CA(j,feapo_12(m, j)+1); % set c_a for each component, which is the second raw of CA
            c_r(j) = CR(j,feapo_12(m, j)+1); % set c_r for each component, which is the second raw of CR 
            r(j) = R(j, feapo_12(m, j)+1);  % set c_r for each component, which is the second raw of CR
            mu(j) = Mu(j, feapo_12(m, j)+1); % set mu for each component, which is the second raw of Mu
            sigma(j) = Sigma(j, feapo_12(m, j)+1); % set sigma for each component, which is the second raw of Sigma
       end
        display (c_a);
        feapoLCC_12(m) = LCC(c_a,c_r,r,mu,sigma,D_0);
        display(feapoLCC_12(m));
        if(feapoLCC_12(m) < minLCCosts)
            minLCCosts = feapoLCC_12(m);  % find the optimal policy under the condition nth policy = 0 and only one 
                                          % or two policies are different from the optimal policy in n-1 case. 
            display (minLCCosts);
            opp = feapo_12(m,:);
            %display (opp1);
        end
     end

  % start the second round searching for optimal solutions under the condition that the nth policy = 1 and only one
  % or two policies are different from the optimal policy in the (n-1)th case
 opts2 = [Oppn 1];
 display (opts2);  
   for j = 1:n  % set the inital policy of the second round as the nth policy = 1 and the optimal policy of case (n-1) 
       c_a(j) = CA(j,opts2(j)+1); % set c_a for each component, which is the second raw of CA
       c_r(j) = CR(j,opts2(j)+1); % set c_r for each component, which is the second raw of CR 
       r(j) = R(j, opts2(j)+1);  % set c_r for each component, which is the second raw of CR 
       mu(j) = Mu(j, opts2(j)+1); % set mu for each component, which is the second raw of Mu
       sigma(j) = Sigma(j, opts2(j)+1); % set sigma for each component, which is the second raw of Sigma
    end
    display(c_a);
   minLCCosts2 = LCC(c_a,c_r,r,mu,sigma,D_0);
   display(minLCCosts2);
   if (minLCCosts2 < minLCCosts)
      minLCCosts = minLCCosts2;  
      display (minLCCosts);
      opp = opts2; 
      display(opp)
   end
    % searching for the optimal policy whose nth policy = 1, and only one policy of them are different from
                % the optimal policy in the (n-1)th case 
   for m = 1:n-1
       feapo_21(m,:) = opts2; 
       feapo_21(m,m) = mod(opts2(m) + 1, 2);
       display(feapo_21(m,:));
       for j = 1:n
            c_a(j) = CA(j,feapo_21(m,j)+1); % set c_a for each component, which is the second raw of CA
            c_r(j) = CR(j,feapo_21(m,j)+1); % set c_r for each component, which is the second raw of CR 
            r(j) = R(j, feapo_21(m,j)+1);  % set c_r for each component, which is the second raw of CR
            mu(j) = Mu(j, feapo_21(m,j)+1); % set mu for each component, which is the second raw of Mu
            sigma(j) = Sigma(j, feapo_21(m,j)+1); % set sigma for each component, which is the second raw of Sigma
        end
        display (c_a);
        feapoLCC_21(m) = LCC(c_a,c_r,r,mu,sigma,D_0);
        display(feapoLCC_21(m));
        if(feapoLCC_21(m) < minLCCosts)
            minLCCosts = feapoLCC_21(m);
            display (minLCCosts);
            opp = feapo_21(m,:);
            display (opp)
        end
   end
    % start searching the optimal solution whose nth policy = 1, and two
    % polcies of them are different from  the optimal solution of case n-1 

  for m = 1:nchoosek(n-1, 2)  % second find the optimal solution among solutions where nth policy = 1 and two policies are
                            % changed from  the optimal policy for the n-1 case. these combination are exactly the same as
                            % the previous case
     feapo_22(m,:) = opts2;
     feapo_22(m, combi(m,1)) = mod(opts2(combi(m,1)) + 1, 2);
     feapo_22(m, combi(m,2)) = mod(opts2(combi(m,2)) + 1, 2);
       for j = 1:n
            c_a(j) = CA(j,feapo_22(m, j)+1); % set c_a for each component, which is the second raw of CA
            c_r(j) = CR(j,feapo_22(m, j)+1); % set c_r for each component, which is the second raw of CR 
            r(j) = R(j, feapo_22(m, j)+1);  % set c_r for each component, which is the second raw of CR
            mu(j) = Mu(j, feapo_22(m, j)+1); % set mu for each component, which is the second raw of Mu
            sigma(j) = Sigma(j, feapo_22(m, j)+1); % set sigma for each component, which is the second raw of Sigma
       end
        display (c_a);
        feapoLCC_22(m) = LCC(c_a,c_r,r,mu,sigma,D_0);
        display(feapoLCC_22(m));
        if(feapoLCC_22(m) < minLCCosts)
            minLCCosts = feapoLCC_22(m);  % find the optimal policy under the condition both nth policy = 1 and policy = 0  and only one 
                                          % or two policies are different from the optimal policy in n-1 case. 
            display (minLCCosts);
            opp = feapo_22(m,:);
            %display (opp1);
        end

  end
  
%transfer the optimal policy to a decimal number which is eaier for further
%comparison
  Num_opps = 0;
   for m = 1 : length(opp)
       Num_opps = Num_opps + opp(m).* 2^(m-1);
   end 
  
  Opp = [opp, zeros(1,N-n)]; % make the dimension of all the opp identical for storing convinience
  

 
e = cputime-t;
display(e);              
end
















