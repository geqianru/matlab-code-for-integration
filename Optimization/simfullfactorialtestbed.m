%numerical results of the full factorial test bed  for the optimization
%procedure, LCC is simulated.
function [Cas, Crfs,Rs,Mus,Sigmas,c_p, D_0, ed_f, simminLCC, opts, Num_opts, e] = simfullfactorialtestbed(instanceno)
 t = cputime;
 T = 10;
% instanceno: the index of the instance in the full factorial testbed which includes 128 instances. 
% parameter settings of the testbed
% targeted downtime
 ed_fS = [1 1.2];
%acquisition cost
 %CAs(:,1) = [500	1000	1500	2000	2500	3000	3500	4000	4500	5000];
 %CAs(:,2) = 2 * [500	1000	1500	2000	2500	3000	3500	4000	4500	5000]; 
 %CAs(:,3) = 3 * [500	1000	1500	2000	2500	3000	3500	4000	4500	5000];
 CAS(:,:,1) = [500	1000	1500	2000	2500	3000	3500	4000	4500	5000; 1000	2000	3000	4000	5000	6000	7000	8000	9000	10000];
 CAS(:,:,2) = [500	1000  1500	2000	2500	3000	3500	4000	4500	5000; 1500	3000 4500 6000	7500	9000	10500	12000	13500	15000];
%repair cost factor
 %CR_fs(:,1) = [0.2 0.3 0.4]; 3 values rotate
 %CR_fs(:,2) = [0.2 0.4 0.6]; 3 values rotate
 %CR_fs(:,1) = [0.2 0.4 0.3 0.2 0.4 0.3 0.2 0.4 0.3 0.2];
 %CR_fs(:,2) = [0.3 0.2 0.4 0.3 0.2 0.4 0.3 0.2 0.4 0.3]; with small distance
 %CR_fs(:,3) = [0.2 0.6 0.4 0.2 0.6 0.4 0.2 0.6 0.4 0.2];
 %CR_fs(:,4) = [0.4 0.2 0.6 0.4 0.2 0.6 0.4 0.2 0.6 0.4]; with large distance
 CRfS(:,:,1) = [0.2	  0.4   0.3   0.2   0.4   0.3   0.2   0.4   0.3   0.2; 0.3  0.2  0.4  0.3  0.2  0.4  0.3  0.2  0.4  0.3];
 CRfS(:,:,2) = [0.2 0.6 0.4 0.2 0.6 0.4 0.2 0.6 0.4 0.2; 0.4 0.2 0.6 0.4 0.2 0.6 0.4 0.2 0.6 0.4];
%repair time
 %Rs(:,1) = [1 2 3 4 5];
 %Rs(:,2) = [1 4 7 10 13];
 %Rs(:,1) = [1 3 5 2 4 1 3 5 2 4]; 
 %Rs(:,2) = [2 4 1 3 5 2 4 1 3 5];
 %Rs(:,3) = [1 7  13 4 10 1 7  13 4 10];
 %Rs(:,4) = [4 10  1 7 13 4 10  1 7 13];
 RS(:,:,1) = [1 3 5 2 4 1 3 5 2 4; 2 4 1 3 5 2 4 1 3 5];
 RS(:,:,2) = [1 7 13 4 10 1 7  13 4 10; 4 10  1 7 13 4 10  1 7 13];
%mu
 %Mus(:,1) = [0.15 0.2 0.25 0.3 0.35 0.4 0.45];  
 %Mus(:,2) = [0.15 0.3 0.45 0.6 0.75 0.9 1.05];
 %Mus(:,1) = [0.15 0.25 0.35 0.45 0.2  0.3  0.4  0.15 0.25 0.35];
 %Mus(:,2) = [0.2  0.3  0.4  0.15 0.25 0.35 0.45 0.2  0.3  0.4];
 %Mus(:,3) = [0.15 0.45 0.75 1.05 0.3  0.6  0.9  0.15 0.45 0.75];
 %Mus(:,4) = [0.3  0.6  0.9  0.15 0.45 0.75 1.05 0.3  0.6  0.9];
 MuS(:,:,1) = [0.15 0.25 0.35 0.45 0.2  0.3  0.4  0.15 0.25 0.35; 0.2  0.3  0.4  0.15 0.25 0.35 0.45 0.2  0.3  0.4];
 MuS(:,:,2) = [0.15 0.45 0.75 1.05 0.3  0.6  0.9  0.15 0.45 0.75; 0.3  0.6  0.9  0.15 0.45 0.75 1.05 0.3  0.6  0.9];
%sigma_f
% Sigmas(:,1) = [0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60];
% Sigmas(:,2) = [0.10 0.30 0.50 0.70 0.90 1.10 1.30 1.50 1.70 1.90 2.10];
 %Sigmas(:,1) = [0.10 0.20 0.30 0.40 0.50 0.60 0.15 0.25 0.35 0.45];
 %Sigmas(:,2) = [0.15 0.25 0.35 0.45 0.55 0.10 0.20 0.30 0.40 0.50];
 %Sigmas(:,3) = [0.10 0.50 0.90 1.30 1.70 2.10 0.30 0.70 1.10 1.50]; 
 %Sigmas(:,4) = [0.30 0.70 1.10 1.50 1.90 0.10 0.50 0.90 1.30 1.70];
 SigmaS(:,:,1) = [0.10 0.20 0.30 0.40 0.50 0.60 0.15 0.25 0.35 0.45; 0.15 0.25 0.35 0.45 0.55 0.10 0.20 0.30 0.40 0.50];
 SigmaS(:,:,2) = [0.10 0.50 0.90 1.30 1.70 2.10 0.30 0.70 1.10 1.50; 0.30 0.70 1.10 1.50 1.90 0.10 0.50 0.90 1.30 1.70];
%penalty cost factor
 c_ps = [1000 10000];
 
 
 
 % change the index of each instance to a binary number
    function L = bits(k,n)
        for i = 1:n
            L(i) = mod(floor(k./2^(i-1)),2);
        end
    end

    S1 = bits (instanceno - 1, 7);
    display(S1);
    for j = 1:7
        if (j==1)
            ed_f = ed_fS(S1(j)+1);
        elseif (j==2)
            Cas = CAS(:,:,S1(j)+1);
        elseif (j==3)
            Crfs = CRfS(:,:,S1(j)+1);
        elseif (j==4)
            Rs = RS(:,:,S1(j)+1);
        elseif (j==5)
            Mus = MuS(:,:,S1(j)+1);
        elseif (j==6)
            Sigmas = SigmaS(:,:,S1(j)+1);
        else
            c_p = c_ps(S1(j)+1);            
        end
    end
 D_0 = sum(sum(0.5.*(Mus .* Rs))).*T * ed_f;
 display(D_0);
 simminLCC = Inf;
 opts = zeros(10, 1); % set the initial value for optimal policy
    for m = 1:1024
        S2 = bits(m-1,10);
        for j = 1:10
            c_a(j) = Cas(S2(j)+1,j);
            c_r(j) = Crfs(S2(j)+1,j);
            r(j) = Rs(S2(j)+1,j);
            mu(j) = Mus(S2(j)+1,j);
            sigma(j) = Sigmas(S2(j)+1,j);
        end
        [simLCCosts(m)]=simLCC(c_a,c_r,r,mu,sigma,D_0,c_p);
        if(simLCCosts(m) < simminLCC)
            simminLCC = simLCCosts(m);
            opts = S2;
        end
    end
    display(opts);
    %change the binary opts to a decimal number for easier comparsion
    Num_opts = 0;
   for m = 1 : length(opts)
       Num_opts = Num_opts + opts(m).* 2^(m-1);
   end
    e = cputime - t;
end


