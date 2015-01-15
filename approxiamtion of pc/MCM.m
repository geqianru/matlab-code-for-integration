%t = cputime;
%R = zeros(20,4);
% for n = 2:100
%     display(n);
%     for i = 1:20
%         display(i);
%         R(n,i)= MCUN(n);
%     end
%     t(n) = PenGamU3(n);
%     Avg(n) = mean(R(n,i));
%     GAP(n) = abs(t(n)- Avg(n))./t(n);
%     s(n) = std(R(n,:));
%     Upper(n) = Avg(n) -1.96.*std(R(n,:))./sqrt(length(i));
%     Lower(n) = Avg(n) +1.96.*std(R(n,:))./sqrt(length(i));
% end
% for n = 2:100
%     display(n);
%     for i = 1:20
%         display(i);
%         R(n,i)= MCNN(n);
%     end
%     j(n) = n;
%     t(n) = PenGamN(n);
%     Avg(n) = mean(R(n,:));
%     GAP(n) = abs(t(n)- Avg(n))./t(n);
%     s(n) = std(R(n,:));
%     Upper(n) = t(n) -1.96.*std(R(n,:))./sqrt(length(i));
%     Lower(n) = t(n) +1.96.*std(R(n,:))./sqrt(length(i));
% end
% e = cputime-t;
% display(e);
% plot(j,t,j,Lower,'--',j,Upper,':');
% plot(j,GAP);
% plot(j,Gap);
% 
% i=1;
% D_0(i)=0;
% while(D_0(i)>=0&&D_0(i)<70)
% R3(i)=MCU3(D_0(i));
% D_0(i+1)=D_0(i)+2;
% i=i+1;
% display([i]);
% end
% R3(i)=d(D_0(i),0,0);
% plot(D_0,R3,'r','DisplayName','(0,0)')
% hold on
%  for n = 1:20
%      display(n);
%      for i = 1:4
%          R(n,i)= MCU3((n-1)*3.5);
%      end
%      j(n) = (n-1)*3.5;
%      t(n) = PenGamU3((n-1)*3.5);
% %      M(n) = MCU3((n-1)*3.5);
%      Avg(n) = mean(R(n,:));
%      GAP(n) = abs(t(n)- Avg(n))./t(n);
%  end
  for n = 1:5
     display(n);
     j(n) = n*0.1;
     t(n) = PenGamU3(n*0.1);
     M(n) = MCU3(n*0.1);    
    GAP(n) = abs(t(n)- M(n))./t(n)*100 ;
  end
plot(j,t,'b',j,M,'r--o')
%e = cputime-t;
%display(e);
% plot(j,t,'b',j,Avg,'r--o');
xlabel('r_1 (day/repair time)');
% ylabel('Gap %')
ylabel('Penalty costs (€)');
% plot(j,Gap);
% xlabel('D_0');
xlabel('r_1 (day/repair time)');
ylabel('Gap %');
% plot(j,GAP);
% plot(j,Gap);
        