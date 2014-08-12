function [inte] = MCUN(n)
t = cputime;
samples = 10000;
T = 10;
c_p = 72000;
lambdas = zeros(samples,1);
  for i = 1:40
      if i<=2
        as(i) = 0.25;
        bs(i) = 0.75;
        rs(i) = 2.5;
      elseif (i>2)&&(i<=10)
        as(i) = 0.15;
        bs(i) = 0.65;
        rs(i) = 2;
      elseif (i>40)&&(i<=60)
        as(i) = 0.10;
        bs(i) = 0.60;
        rs(i) = 1.5;
      elseif (i>60)&&(i<=80)
        as(i) = 0.15;
        bs(i) = 0.45;
        rs(i) = 1;
      else (i>80)&&(i<=100)
        as(i) = 0.10;
        bs(i) = 0.40;
        rs(i) = 1;
      end     
       mus(i) = 0.5 * (as(i) + bs(i));
       %pdf_i(i) = 1/(bs(i)-as(i));
       lambdas(i) = as(i)+rand(samples,1)*(bs(i)-as(i));
  end
   

       
  D_0 = sum (mus .* rs).*T ;
  %Bound=(b_1-a_1).*(b_2-a_2);
  Bound = prod(bs-as);
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inside integral%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    function ii=yi(x,i)
%             ii=poisspdf(i,x.*T);
%    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Convolution of the Possion part%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   function y1=pos(x) 
%    sum = 0;
%     for i = 1:3000
%                   downcost = max(0,(i-1).* rs(1)-D_0);
% %                 display(i);
% %                 display(j);
% %                 display(downtime);
%                 sum=sum+poisspdf(i-1,x.*T) * downcost; 
%     end
%    y1 = sum .* prod(pdf_i).*c_p;
%    %display(y1);
%   end
                    
%%%%%%%%%%%%%%%Approximate the randomness of lambda by Monte Carlo Method%%
inte=sum(pos(lambdas))/samples.*Bound;
e = cputime-t;
display(e);
display(inte);

end


