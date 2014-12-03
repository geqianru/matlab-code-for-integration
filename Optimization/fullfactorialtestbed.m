%numerical results of the full factorial test bed  for the optimization
%procedure, LCC is approximated
function [Cas, Crfs, Mus,c_v, Sigmas, c_p, D_0, ed_f, LCCosts, minLCC, opts, Num_opts, e] = fullfactorialtestbed(instanceno)
%Cas, Crfs,Rs,Mus,Sigmas,c_p, D_0, ed_f, 
 t = cputime;
 display (instanceno);
 T = 10;
% instanceno: the index of the instance in the full factorial testbed which includes 128 instances. 
% parameter settings of the testbed
% targeted downtime
 ed_fS = [1 1.1 1.2];
%acquisition cost
 %CAs(:,1) = [500	1000	1500	2000	2500	3000	3500	4000	4500	5000];
 %CAs(:,2) = 2 * [500	1000	1500	2000	2500	3000	3500	4000	4500	5000]; 
 %CAs(:,3) = 3 * [500	1000	1500	2000	2500	3000	3500	4000	4500	5000];
 CAS(:,:,1) = [500	1000  1500	2000	2500	3000	3500	4000	4500	5000; 750	1500	2250	3000	3750	4500	5250	6000	6750	7500];
 CAS(:,:,2) = [500	1000  1500	2000	2500	3000	3500	4000	4500	5000; 1000	2000	3000	4000	5000	6000	7000	8000	9000	10000];
 CAS(:,:,3) = [500	1000  1500	2000	2500	3000	3500	4000	4500	5000; 1250	2500    3750    5000	6250	7500	8750	10000   11250	12500];
%repair cost factor
 %CR_fs(:,1) = [0.2 0.3 0.4]; 3 values rotate
 %CR_fs(:,2) = [0.2 0.4 0.6]; 3 values rotate
 %CR_fs(:,1) = [0.2 0.4 0.3 0.2 0.4 0.3 0.2 0.4 0.3 0.2];
 %CR_fs(:,2) = [0.3 0.2 0.4 0.3 0.2 0.4 0.3 0.2 0.4 0.3]; with small distance
 %CR_fs(:,3) = [0.2 0.6 0.4 0.2 0.6 0.4 0.2 0.6 0.4 0.2];
 %CR_fs(:,4) = [0.4 0.2 0.6 0.4 0.2 0.6 0.4 0.2 0.6 0.4]; with large distance
 %CRfS(:,:,1) = [0.2	  0.4   0.3   0.2   0.4   0.3   0.2   0.4   0.3   0.2; 0.3  0.2  0.4  0.3  0.2  0.4  0.3  0.2  0.4  0.3];
 %CRfS(:,:,2) = [0.2 0.6 0.4 0.2 0.6 0.4 0.2 0.6 0.4 0.2; 0.4 0.2 0.6 0.4 0.2 0.6 0.4 0.2 0.6 0.4];
%repair time
 %Rs(:,1) = [1 2 3 4 5];
 %Rs(:,2) = [1 4 7 10 13];
 %Rs(:,1) = [1 3 5 2 4 1 3 5 2 4]; 
 %Rs(:,2) = [2 4 1 3 5 2 4 1 3 5];
 %Rs(:,3) = [1 7  13 4 10 1 7  13 4 10];
 %Rs(:,4) = [4 10  1 7 13 4 10  1 7 13];
 %RS(:,:,1) = [1 3 5 2 4 1 3 5 2 4; 2 4 1 3 5 2 4 1 3 5];
 %RS(:,:,2) = [1 7 13 4 10 1 7  13 4 10; 4 10  1 7 13 4 10  1 7 13];
%mu
 %Mus(:,1) = [0.15 0.2 0.25 0.3 0.35 0.4 0.45];  
 %Mus(:,2) = [0.15 0.3 0.45 0.6 0.75 0.9 1.05];
 %Mus(:,1) = [0.15 0.25 0.35 0.45 0.2  0.3  0.4  0.15 0.25 0.35];
 %Mus(:,2) = [0.2  0.3  0.4  0.15 0.25 0.35 0.45 0.2  0.3  0.4];
 %Mus(:,3) = [0.15 0.45 0.75 1.05 0.3  0.6  0.9  0.15 0.45 0.75];
 %Mus(:,4) = [0.3  0.6  0.9  0.15 0.45 0.75 1.05 0.3  0.6  0.9];
 MuS(:,:,1) = [0.5	0.75 0.4	0.65	0.85	0.35	0.45	0.95	0.3	0.4; 0.45   0.75	0.38    0.4 0.75    0.32	0.43    0.95    0.25	0.4];
 MuS(:,:,2) = [0.5	0.75 0.4	0.65	0.85	0.35	0.45	0.95	0.3	0.4; 0.3375	0.5625	0.285	0.3	0.5625	0.24	0.3225	0.7125	0.1875	0.3];
 Mus(:,:,3) = [0.5	0.75 0.4	0.65	0.85	0.35	0.45	0.95	0.3	0.4; 0.225	0.375	0.19	0.2	0.375	0.16	0.215	0.475	0.125	0.2];
 %levels of coefficant of variant c_v
 c_vs = [0.25 0.5 1];
 
 %sigma_f
% after the levels of mu and c_v had been choosen, there are nine levels of
% signmas for each combination of c_v and mu;
% mu_1 and c_v1
SigmaS(:,:,1) = [0.35	0.3	    0.37	0.41	0.4	    0.38	0.38	0.36	0.38	0.4;   0.3	   0.24	    0.37	0.41	0.35	0.3	    0.38	0.22	0.35	0.35] ;
% mu_1 and c_v2
SigmaS(:,:,2) = [0.798	0.684	0.8436	0.9348	0.912	0.8664	0.8664	0.8208	0.8664	0.912; 0.696   0.5568	0.8584	0.9512	0.812	0.696	0.8816	0.5104	0.812	0.812] ;
% mu_1 and c_v3
SigmaS(:,:,3) = [1.6415	1.407	1.7353	1.9229	1.876	1.7822	1.7822	1.6884	1.7822	1.876; 1.437	1.1496	1.7723	1.9639	1.6765	1.437	1.8202	1.0538	1.6765	1.6765] ;
% mu_2 and c_v1
SigmaS(:,:,4) = [0.35	0.37	0.3	    0.41	0.4	    0.38	0.36	0.38	0.38	0.4;   0.2073	0.16584	0.25567	 0.28331	0.24185	 0.2073	 0.26258  0.15202	0.24185	0.24185] ;
% mu_2 and c_v2
SigmaS(:,:,5) = [0.798	0.8436	0.684	0.9348	0.912	0.8664	0.8208	0.8664	0.8664	0.912; 0.5145	0.4116	0.63455	 0.70315	0.60025	 0.5145	 0.6517	  0.3773	0.60025	0.60025] ;
% mu_2 and c_v3
SigmaS(:,:,6) = [1.6415	1.7353	1.407	1.9229	1.876	1.7822	1.6884	1.7822	1.7822	1.876; 1.074	0.8592	1.3246	 1.4678	    1.253	 1.074	 1.3604	  0.7876	1.253	1.253] ;
% mu_3 and c_v1
SigmaS(:,:,7) = [0.35	0.37	0.3	0.41	0.4	0.38	0.36	0.38	0.38	0.4; 0.111	0.0888	0.1369	0.1517	0.1295	0.111	0.1406	0.0814	0.1295	0.1295] ;
% mu_3 and c_v2
SigmaS(:,:,8) = [0.798	0.8436	0.684	0.9348	0.912	0.8664	0.8208	0.8664	0.8664	0.912; 0.333	0.2664	0.4107	0.4551	0.3885	0.333	0.4218	0.2442	0.3885	0.3885] ;
% mu_3 and c_v3
SigmaS(:,:,9) = [1.6415	1.7353	1.407	1.9229	1.876	1.7822	1.6884	1.7822	1.7822	1.876; 0.711	0.5688	0.8769	0.9717	0.8295	0.711	0.9006	0.5214	0.8295	0.8295] ;
 
%penalty cost factor
 c_ps = [1000 10000 100000];
 % the repair time for every comppoent every alternative design is a constant value, 
 Rs = 3; 
 % the proportion of the repair cost in the acquistion costs  for  every alternative of every component is a constant value as well;
 Crfs = 0.3;
 
 % change the index of each instance to a Ternary number (????)
    function T = bits1(k,n)
        for i = 1:n
            T(i) = mod(floor(k./3^(i-1)),3);
        end
    end
% change the index of different feasible solutions into an binary number,
% because for each component there are only two alternative designs to choose from 
    function B = bits2(k,n)
        for i = 1:n
            B(i) = mod(floor(k./2^(i-1)),2);
        end
    end

    S1 = bits1 (instanceno - 1, 5);
    display(S1);
    for j = 1:5
        if (j==1)
            ed_f = ed_fS(S1(j)+1);
        elseif (j==2)
            Cas = CAS(:,:,S1(j)+1);
        elseif (j==3)
            Mus = MuS(:,:,S1(j)+1);
        elseif (j==4)
            c_v = c_vs(S1(j)+1);
        else
            c_p = c_ps(S1(j)+1);            
        end
    end
    Sigmas = SigmaS(:,:,(S1(4)) * 3 + (S1(5)+1));
    %display (Sigmas);
 D_0 = sum(sum(0.5.*(Mus .* Rs))).*T * ed_f;
 %display(D_0);
 minLCC = Inf;
 opts = zeros(10, 1); % set the initial value for optimal policy
    for m = 1:1024
        S2 = bits2(m-1,10);
        for j = 1:10
            c_a(j) = Cas(S2(j)+1,j);
            c_r(j) = Crfs * Cas(S2(j)+1,j);
            r(j) = Rs;
            mu(j) = Mus(S2(j)+1,j);
            sigmas(j) = Sigmas(S2(j)+1,j);
        end
    [LCCosts(m)] = LCC(c_a,c_r,r,mu,sigmas,D_0,c_p);
    %[simLCCosts(m),C_ap(m),C_rp(m),C_pp(m)] = simLCC(c_a,c_r,r,mu,sigma,D_0,c_p);
        if(LCCosts(m) < minLCC)
            minLCC = LCCosts(m);
            opts = S2;
        end
    end
    %display(opts);
    %change the binary opts to a decimal number for easier comparsion
    Num_opts = 0;
   for m = 1 : length(opts)
       Num_opts = Num_opts + opts(m).* 2^(m-1);
   end
    e = cputime - t;
end


