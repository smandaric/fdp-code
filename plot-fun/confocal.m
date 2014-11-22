% 


load('data.mat');

samples = {
    'Sample Name', 'Group';
    '141003-5', 1;
    '141003-6', 1;
    '141003-8', 1;
    %'141009-1', 2;
    '141009-2', 2;
    '141009-3', 2;
    };

names = {'Phase contrast', 'Confocal'};

colors = {[215,25,28]/255 [43,131,186]/255};

handles = [0];

hold on

for i = 2:length(samples)
    
    fullName = strjoin({samples{i,1}, '.mat'},'');
    
    index = find(strcmp(fullName,data));
    group = samples{i,2};
    
    plot_handle = plot(data{index,3},data{index,4},'-');
    
    set(plot_handle, 'Color', colors{group});
    set(plot_handle, 'LineWidth', 3);
    
    handles = [handles, plot_handle];
    
end

title('Gelling front positions')
xlabel('Time [s]')
ylabel('Distance [m]')

ax = gca;
ax.YLim = [0 14e-4];

legend(handles([2 5]),names,'Location','SouthEast')
hold off


