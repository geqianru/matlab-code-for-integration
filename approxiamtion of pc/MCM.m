for n = 2:100
    for i = 1:20
        t(i)= MC(n);
    end
    Avg(n)= mean(t);
    GAP(n)= abs(PenGamU3(n)-Avg(n))./Avg(n);
end
        