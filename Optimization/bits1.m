    function T = bits1(k,n)
        for i = 1:n
            T(i) = mod(floor(k./3^(i-1)),3);
        end
    end