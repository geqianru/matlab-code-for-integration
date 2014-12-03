function [minLCCosts,Opp,e,D_0]= partialenumeration(n,Oppn)
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
  
  Opp = [opp, zeros(1,N-n)]; % make the dimension of all the opp identical for storing convinience
 
  
e = cputime-t;
display(e);              
end
















