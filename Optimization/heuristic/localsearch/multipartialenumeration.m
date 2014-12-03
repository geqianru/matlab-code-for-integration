% get the solutions by using partial enumeration when n is from 1 to 27.
t = cputime;
opp(2,:) = [0 1 0 0 0 0 0 0 0 0];
for i = 1:8
    display (i+2);
    [minLCCosts(i+2), opp(i+2,:),e(i+2),D_0(i+2),Num_opps(i+2)] = partialenumeration2(i+2,opp(i+1,:));    
end
e2 = cputime-t;