% plot a list of figures of downtime for all the cases under a specificed n
% and sigma in one page.
clear all;
% n = [5 50 100];
% sigma_f = [0.2 0.35 0.5];
% figure;
% set(gcf, 'color', 'white');
% %subplot(length(n), length(sigma_f),1);
% for ni = 1:length(n)
%     for sj = 1:length(sigma_f)
%         subplot(length(n), length(sigma_f), (ni-1)*length(n)+sj)
%         d = exdownunisn(n(ni),sigma_f(sj));
%         [f,xi] = ksdensity(d);
%         plot(xi,f,'LineStyle','--','LineWidth',2);
%         hold on
%         Downtimegammanexceed(n(ni),sigma_f(sj));
%         hold off
%         titlestring = strcat('n=',num2str(n(ni)),', \sigma=',num2str(sigma_f(sj)),'\mu');
%         title(titlestring,'FontName','umbxti10');
%     end
% end
n = [5 50 100];
sigma_f = [0.2 0.35 0.5];
figure;
set(gcf, 'color', 'white');
%subplot(length(n), length(sigma_f),1);
for ni = 1:length(n)
    for sj = 1:length(sigma_f)
        subplot(length(n), length(sigma_f), (ni-1)*length(n)+sj)
%         ylim([0 0.015])
        plotmixerlanglognormaln(n(ni),sigma_f(sj));
        titlestring = strcat('n=',num2str(n(ni)),', \sigma=',num2str(sigma_f(sj)),'\mu');
        title(titlestring,'FontName','umbxti10');
    end
end
