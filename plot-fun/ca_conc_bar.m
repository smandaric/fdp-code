% 

clear 
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
colors = {[215,25,28]/255 [253,174,97]/255 [171,221,164]/255 [43,131,186]/255};
%colors = {'red', 'green', 'blue', 'yellow'};
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


errorbar(group_mean,group_std,'LineStyle','None','Color','b');
hold on
bar(group_mean)
hold off
set(gca,'XTick',[1 2 3 4 5 6],'XTickLabelMode','manual','XTickLabel',names)
%set(gca,'XTickLabelRotation',90) % add with new matlab

title('Gelling rate for different Ca^2^+ concentrations')
xlabel('Concentration')
ylabel('Speed')


% Line charts
cca = [1000 750 500 250 100 50];
figure
plot(cca, group_mean, '*')
parm = polyfit(cca,group_mean,1);
refline(parm(1),parm(2))
title('Linear gelling velocities')
xlabel('Ca^2^+ conc')
ylabel('speed m/s')


figure
plot(sqrt(cca), group_mean, '*')
sqparm = polyfit(sqrt(cca),group_mean,1);
refline(sqparm(1),sqparm(2))
title('Linear gelling velocities - square root conc')
xlabel('Square root Ca^2^+ conc')
ylabel('speed m/s')

close all
% This one is used for paper
figure
err_handle = errorbar(cca, group_mean, group_std);
title('Linear gelling velocities')
xlabel('Ca^2^+ [mM]')
ylabel('Speed [m/s]')
err_handle.LineStyle = 'none';
err_handle.Marker = '*';
set(gca,'XTick', [0:100:1200]);

