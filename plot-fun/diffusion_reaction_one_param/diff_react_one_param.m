
% single ensemble of parameters, showing how the function behaves
% [1]    [1.0000e-11]    [0.5000]    [10]    [301x5000x3 double]    [1x5000 double]    [1x301 double]
%load('modeldata.mat')
pd = simData(10,:);
plot_handles = plotProfiles(cell2mat(pd(5)),cell2mat(pd(6)),cell2mat(pd(7)),[1, 61, 121, 181, 241],[1,3],'crop');
set(gcf, 'Position', [100 100 640 480])
for handle = plot_handles
    set(handle,'LineWidth',2)
end

    


figure;
plot_handles = plotProfiles(cell2mat(pd(5)),cell2mat(pd(6)),cell2mat(pd(7)),[1, 61, 121, 181, 241],[4],'crop');
set(gcf, 'Position', [150 150 640 480])
for handle = plot_handles
    set(handle,'LineWidth',2)
    set(handle,'Color',[0.2157 0.4941 0.7216])
end