%numerical results of the full factorial test bed  for the optimization
%procedure, LCC is approximated
function [Cas, Crfs,Rs,Mus,c_p, D_0, ed_f, exminLCC, opts, Num_opts, e] = expectedfullfactorialtestbed(instanceno)
 t = cputime;
 T = 10;
% instanceno: the index of the instance in the full factorial testbed which includes 128 instances. 
% parameter settings of the testbed
% targeted downtime
 ed_fS = [1 1.2];
%acquisition cost
 CAS(:,:,1) = [500	1000	1500	2000	2500	3000	3500	4000	4500	5000; 1000	2000	3000	4000	5000	6000	7000	8000	9000	10000];
 CAS(:,:,2) = [500	1000  1500	2000	2500	3000	3500	4000	4500	5000; 1500	3000 4500 6000	7500	9000	10500	12000	13500	15000];
%repair cost factor
 CRfS(:,:,1) = [0.2	  0.4   0.3   0.2   0.4   0.3   0.2   0.4   0.3   0.2; 0.3  0.2  0.4  0.3  0.2  0.4  0.3  0.2  0.4  0.3];
 CRfS(:,:,2) = [0.2 0.6 0.4 0.2 0.6 0.4 0.2 0.6 0.4 0.2; 0.4 0.2 0.6 0.4 0.2 0.6 0.4 0.2 0.6 0.4];
%repair time
 RS(:,:,1) = [1 3 5 2 4 1 3 5 2 4; 2 4 1 3 5 2 4 1 3 5];
 RS(:,:,2) = [1 7 13 4 10 1 7  13 4 10; 4 10  1 7 13 4 10  1 7 13];
%mu
 MuS(:,:,1) = [0.15 0.25 0.35 0.45 0.2  0.3  0.4  0.15 0.25 0.35; 0.2  0.3  0.4  0.15 0.25 0.35 0.45 0.2  0.3  0.4];
 MuS(:,:,2) = [0.15 0.45 0.75 1.05 0.3  0.6  0.9  0.15 0.45 0.75; 0.3  0.6  0.9  0.15 0.45 0.75 1.05 0.3  0.6  0.9];
%sigma_f
 %SigmaS(:,:,1) = [0.10 0.20 0.30 0.40 0.50 0.60 0.15 0.25 0.35 0.45; 0.15 0.25 0.35 0.45 0.55 0.10 0.20 0.30 0.40 0.50];
 %SigmaS(:,:,2) = [0.10 0.50 0.90 1.30 1.70 2.10 0.30 0.70 1.10 1.50; 0.30 0.70 1.10 1.50 1.90 0.10 0.50 0.90 1.30 1.70];
%penalty cost factor
 c_ps = [1000 10000];
 
 
 
 % change the index of each instance to a binary number
    function L = bits(k,n)
        for i = 1:n
            L(i) = mod(floor(k./2^(i-1)),2);
        end
    end

    S1 = bits (instanceno - 1, 6);
    display(S1);
    for j = 1:6
        if (j==1)
            ed_f = ed_fS(S1(j)+1);
        elseif (j==2)
            Cas = CAS(:,:,S1(j)+1);
        elseif (j==3)
            Crfs = Cas .* CRfS(:,:,S1(j)+1);
        elseif (j==4)
            Rs = RS(:,:,S1(j)+1);
        elseif (j==5)
            Mus = MuS(:,:,S1(j)+1);
        %elseif (j==6)                      % variation of the failure rate is not considered in this heuristic method
            %Sigmas = SigmaS(:,:,S1(j)+1);
        else
            c_p = c_ps(S1(j)+1);            
        end
    end
 D_0 = sum(sum(0.5.*(Mus .* Rs))).*T * ed_f;
 display(D_0);
 exminLCC = Inf;
 opts = zeros(10, 1); % set the initial value for optimal policy
    for m = 1:1024
        S2 = bits(m-1,10);
        for j = 1:10
            c_a(j) = Cas(S2(j)+1,j);
            c_r(j) = Crfs(S2(j)+1,j);
            r(j) = Rs(S2(j)+1,j);
            mu(j) = Mus(S2(j)+1,j);
            %sigma(j) = Sigmas(S2(j)+1,j);
        end
        [ExLCCosts(m)] = ExLCC(c_a,c_r,r,mu,D_0,c_p);
        if(ExLCCosts(m) < exminLCC)
            exminLCC = ExLCCosts(m);
            opts = S2;
            display(opts);
        end
    end
    %change the binary opts to a decimal number for easier comparsion
    Num_opts = 0;
   for m = 1 : length(opts)
       Num_opts = Num_opts + opts(m).* 2^(m-1);
   end
    e = cputime - t;
end


