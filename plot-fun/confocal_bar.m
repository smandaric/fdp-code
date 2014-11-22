% 

clear 

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



handles = [0];

group_mean = [];
group_std = [];

for i = 1:length(names)
    
    group_index = find([samples{2:end,2}]==i) +1 ;
    index = [];
    
    
    for j = 1:length(group_index)
        fullName = strjoin({samples{group_index(j),1}, '.mat'},'');
        index(j) = find(strcmp(fullName,data));
    end
    
    
    group_mean(i) = mean([data{index,5}]);
    group_std(i) = std([data{index,5}]); 
    
    
    
end

bar(group_mean)

hold on
errorbar(group_mean,group_std,'LineStyle','None','Color','black');
hold off
set(gca,'XTick',[1:length(names)],'XTickLabelMode','manual','XTickLabel',names)
%set(gca,'XTickLabelRotation',90) % add with new matlab


