% compute the actual cost of different method

for i = 1 : 128
    [simLCCosts(i), C_ap(i),C_rp(i),C_pp(i)] = ActLCCsimoptifullfactorialtestbed(opts(i,:),D_0(i),Cas(:,:,i),Crfs(:,:,i),Rs(:,:,i),Mus(:,:,i),Sigmas(:,:,i),c_p(i));
    %[simLCCosts,C_ap,C_rp,C_pp] = ActLCCsimoptifullfactorialtestbed(opts, D_0,Cas,Crfs,Rs,Mus,Sigmas,c_p)
end

% for i = 1 : 128
%     [C_ap(i),C_rp(i),C_pp(i)] = ActLCCsimoptifullfactorialtestbed2(i, opts(i,:));
% end