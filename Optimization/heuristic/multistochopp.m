clc;
clear all;
for i = 1:22
    [stochnumminLCC(i,:),Opts(i,:),e(i,:),D_0(i,:)] = stochnumopp(i);
end