    function L = bits(instanceno)
        for i = 1:5
            L(i) = mod(floor(instanceno./3^(i-1)),3);
        end
    end