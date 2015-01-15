%plot(n,t,n,Lower,'--',n,Upper,':')
for n = 1:100
     s(n) = n;
     t1(n) = PenGamN(n);
     %t2(n) = downexnor(n);
end
plot(s,t1,'r');
