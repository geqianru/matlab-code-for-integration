clear all;
counter = 0;
% for i = 1:1:2
%     if i==1
%         n = 50;
%     else
%         n = 100;
%     end
%     display(n);
%     for j = 1:1:3
%         sigma = 0.2 * j;
%         display(sigma);
%         for k = 1:1:5
%             display(k);
%             ed_f = 1+(k-1)/10;
%             counter = counter + 1;
%             [avg_gap(counter,:),upper(counter,:),lower(counter,:),avg_sim(counter,:),avg_a(counter,:),Gap(counter,:),avg_s(counter,:),Gupper(counter,:),Glower(counter,:)] = resultscompare(n,sigma,ed_f);
%             %save('D:\MATLAB\approxiamtion of pc\gamma fit\uniform\gap values\compareresult(n,sigma,ed_f.mat');
%             %save compareresult(n,sigma,1+(k-1)/10).mat;        
%         end
%     end
% end
for i = 1:1:2
    if i==1
        n = 50;
        sigma = 0.57;
    else
        n = 100;
        sigma = 0.57;
    end

        for k = 1:1:5
            display(k);
            ed_f = 1+(k-1)/10;
            counter = counter + 1;
            [avg_gap(counter,:),upper(counter,:),lower(counter,:),avg_sim(counter,:),avg_a(counter,:),Gap(counter,:),avg_s(counter,:),Gupper(counter,:),Glower(counter,:)] = resultscompare(n,sigma,ed_f);
            %save('D:\MATLAB\approxiamtion of pc\gamma fit\uniform\gap values\compareresult(n,sigma,ed_f.mat');
            %save compareresult(n,sigma,1+(k-1)/10).mat;        
        end
end
