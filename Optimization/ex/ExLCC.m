function [ExLLcosts]=ExLCC(c_a,c_r,r,mu,D_0,c_p)
T = 10;
C_a = sum(c_a);
%display(C_a);
C_r = sum(mu .* c_r .* T);
%display(C_r);
C_p = Expenalty(r,mu,T,D_0,c_p);
%display(C_p);
ExLLcosts = C_a + C_r + C_p;
%display(LLcosts)
end