% %generate all the 128 instance for the full factorial testbed
% %approximation evaluation
% % for i = 1:128
% %     [Cas(:,:,i), Crfs(:,:,i),Rs(:,:,i),Mus(:,:,i),Sigmas(:,:,i),c_p(i), D_0(i), ed_f(i), minLCC(i), opts(i,:), Num_opts(i), e(i)] = fullfactorialtestbed(i);
% % end
% % 
% % for i = 1: 128
% %     display (i);
% %     [Cas(:,:,i), Crfs(:,:,i),Rs(:,:,i),Mus(:,:,i), c_p(i), D_0(i), ed_f(i), stochminLCC(i), opts(i,:), Num_opts(i), C_apS(i), C_rpS(i), C_ppS(i), e(i)] = stochfullfactorialtestbed(i);
% % end
% 
% % for i = 1 : 128
% %     display(i);
% %     [Cas(:,:,i), Crfs(:,:,i), Rs(:,:,i), Mus(:,:,i), Sigmas(:,:,i), c_p(i), D_0(i), ed_f(i), minLCC(i), opts(i,:), Num_opts(i), e(i)] = fullfactorialtestbed(i);
% % end
%     
% 
% % generate all the 128 instance for the full factorial testbed
% % simulation evaluation
% % for i = 1:128
% %     [Cas(:,:,i), Crfs(:,:,i),Rs(:,:,i),Mus(:,:,i),Sigmas(:,:,i),c_p(i), D_0(i), ed_f(i), simminLCC(i), opts(i,:), Num_opts(i), e(i)] = simfullfactorialtestbed(i);
% % end
% 
% % 
% % generate all the 64 instance for the full factorial testbed
% % heuristic 1, use the expected downtime as the actual downtime ignore the
% % uncertainty both in the number of failures and the variance of the failure rate
% % for i = 1:64
% %     [Cas(:,:,i), Crfs(:,:,i),Rs(:,:,i),Mus(:,:,i), c_p(i), D_0(i), ed_f(i), exminLCC(i), opts(i,:), Num_opts(i), e(i)] = expectedfullfactorialtestbed(i);
% % end
% 
% 
% % generate all the 64 instance for the full factorial testbed
% % heuristic 2, ignore the uncertainty of the failure rate
% % for i = 1 : 64
% %     display(i);
% %     [Cas(:,:,i), Crfs(:,:,i),Rs(:,:,i),Mus(:,:,i), c_p(i), D_0(i), ed_f(i), stochminLCC(i), opts(i,:), Num_opts(i), e(i)] = stochfullfactorialtestbed(i);
% % end
% 
% %
% % for i = 1 : 64
% % [simLCCosts, C_ap,C_rp,C_pp] = ActLCCsimoptifullfactorialtestbed2(i, opts(i));
% % end

%generate 243 instances from the full factorial testbed by full enumeration
%simulation procedure
% for i = 1 : 243
% [Cas(:,:,i), Crfs(i), Mus(:,:,i), c_v(i), Sigmas(:,:,i),c_p(i), D_0(i), ed_f(i), LCCosts(:,i), minLCC(i), opts(:,i), Num_opts(i), e(i)] = fullfactorialtestbed(i);
% end



















