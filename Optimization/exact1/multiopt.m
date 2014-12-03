clc;
clear all;
for i = 1:27
    display(i);
    [minLCC(i,:), Opts(i,:), e(i,:),D_0(i,:),Num_opts(i,:)] = optilcc(i);
end