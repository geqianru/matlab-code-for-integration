   function p = erlangpdf(x,K,Theta)
        p = Theta.^K .* x.^(K-1)/factorial(K-1).* exp(1).^(-Theta*x);
    end


