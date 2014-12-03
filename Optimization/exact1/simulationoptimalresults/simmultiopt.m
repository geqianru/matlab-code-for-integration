clc;
clear all;
for i = 1:17
    display(i);
    [minsimLCC(i,:),Opts(i,:),e(i,:),D_0(i,:), SimNum_opts(i,:)] = simoptilcc(i+10);
end