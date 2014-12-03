clc;
clear all;
for i = 1:20
    [minLCC(i,:),Opts(i,:),e(i,:),D_0(i,:)] = Exoptilcc(i);
end