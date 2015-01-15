n = [5 50 100];
sigma_f = [0.2 0.35 0.5];
figure;
set(gcf, 'color', 'white');
%subplot(length(n), length(sigma_f),1);
for ni = 1:length(n)
    for sj = 1:length(sigma_f)
        subplot(length(n), length(sigma_f), (ni-1)*length(n)+sj)
%         ylim([0 0.015])
        plotmixerlanguniformn(n(ni),sigma_f(sj));
        titlestring = strcat('n=',num2str(n(ni)),', \sigma=',num2str(sigma_f(sj)),'\mu');
        title(titlestring,'FontName','umbxti10');
    end
end