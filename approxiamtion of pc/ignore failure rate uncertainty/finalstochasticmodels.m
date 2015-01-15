clear all;
counter = 0;
n = [5 50 100];
ed_f = [1 1.1 1.2 1.3];
for ni = 1:length(n)
    display(ni);
    for ek = 1:length(ed_f)
        display(ek);
        counter = counter + 1;
        [avg_sf(counter),upper(counter), lower(counter)] = avgexdowntimestocha(n(ni), ed_f(ek));
    end
end