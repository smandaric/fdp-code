% 


load('data.mat');

samples = {
    'Sample Name', 'Group';
    '140804-1', 1;
    '140804-2', 1;
    '140804-3', 1;
    '140804-7', 2;
    '140804-8', 2;
    '140804-9', 2;
    '140804-10', 3;
    '140804-15', 3;
    '140804-16', 3;
    '141008-3', 4;
    '141008-1', 5;
    '141008-2', 5;
    '141008-4', 5;
    '141007-8', 6;
    };
    
names = {'1000 mM Control', '100 mM Control', '50 mM Control', ...
    '1000 mM CuSO_4', '100 mM CuSO_4', '50 mM CuSO_4'};
colors = {[213,62,199]/255
    [252,141,89]/255
    [254,224,139]/255
    [230,245,152]/255
    [153,213,148]/255
    [50,136,189]/255
    };
%colors = {'red', 'green', 'blue', 'yellow'};
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
xlabel('Times [s]')
ylabel('Distance [m]')

legend(handles([2 5 8 11 12 15]),names,'Location','SouthEast')
hold off


