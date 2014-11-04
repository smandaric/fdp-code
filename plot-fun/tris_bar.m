% 
clear

load('data.mat');

samples = {
    'Sample Name', 'Group';
    '140804-7', 1;
    '140804-8', 1;
    '140804-9', 1;
    '140804-10', 2;
    '140804-15', 2;
    '140804-16', 2;
    '141007-1', 3;
    '141007-2', 3;
    '141007-3', 3;
    '141007-4', 4;
    '141007-5', 4;
    '141007-6', 4;
    };
    
names = {'100 mM Control', '50 mM Control'};



slope = [0];

mu = [];
s = [];

for i = 2:length(samples)
    
    fullName = strjoin({samples{i,1}, '.mat'},'');
    index = find(strcmp(data,fullName));
    slope = [slope data{index,5}];
end

for i = 1:4
    same_group = find([samples{2:end,2}] == i) + 1;
    
    mu(i) = mean(slope(same_group));
    s(i) = std(slope(same_group));
end

means = [mu(1) mu(2); mu(3) mu(4)]';
std = [s(1) s(2); s(3) s(4)]';



barwitherr(std,means)
set(gca,'XTick',[1:2],'XTickLabelMode','manual','XTickLabel',names)
legend('Control','25 mM TRIS pH 7.4')

title('Gelling velocity for buffered and unbuffered gelling solution')
xlabel('Gelling solution concentration')
ylabel('Speed µm/s')
