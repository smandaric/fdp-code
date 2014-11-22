% Default colors


load('data.mat');

samples = {
    'Sample Name', 'Group';
    '140804-1', 1;
    '140804-2', 1;
    '140804-3', 1;
    '141024-2', 2;
    '141024-3', 2;
    '141024-4', 2;
    '140804-4', 3;
    '140804-5', 3;
    '140804-6', 3;
    '141024-5', 4;
    '141024-6', 4;
    '141024-7', 4;
    '140804-7', 5;
    '140804-8', 5;
    '140804-9', 5;
    '140804-10', 6;
    '140804-15', 6;
    '140804-16', 6
    };
    
names = {'1000 mM', '750 mM', '500 mM', '250 mM', '100 mM', '50 mM'};

colors = linspecer(6);
handles = [0];

hold on

for i = 2:length(samples)
    
    fullName = strjoin({samples{i,1}, '.mat'},'');
    
    index = find(strcmp(fullName,data));
    group = samples{i,2};
    
    plot_handle = plot(data{index,3},data{index,4},'-');
    
    set(plot_handle, 'Color', colors(group,:));
    set(plot_handle, 'LineWidth', 2);
    
    handles = [handles, plot_handle];
    
end

title('Gelling front positions')
xlabel('Time [s]')
ylabel('Distance [m]')

legend(handles(2:3:end),names,'Location','SouthEast')
hold off

set(gcf, 'Position', [150 150 640 480])

