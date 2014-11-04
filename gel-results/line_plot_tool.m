% 


load('data.mat');

samples = {
    'Sample Name', 'Group';
    '140804-1', 1;
    '140804-2', 1;
    '140804-3', 1;
    '140804-10', 2;
    '140804-15', 2;
    '140804-16', 2;
    '140804-7', 3;
    '140804-8', 3;
    '140804-9', 3;
    '140804-10', 4;
    '140804-15', 4;
    '140804-16', 4
    };
    
names = {'1000 mM', '500 mM', '100 mM', '50 mM'};
colors = {[215,25,28]/255 [253,174,97]/255 [171,221,164]/255 [43,131,186]/255};
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

legend(handles(2:3:end),names,'Location','SouthEast')
hold off


