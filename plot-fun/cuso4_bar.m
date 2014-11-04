% 

clear
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
    
names = {'1000 mM', '100 mM', '50 mM'};


slope = [0];

mu = [];
s = [];

for i = 2:length(samples)
    
    fullName = strjoin({samples{i,1}, '.mat'},'');
    index = find(strcmp(data,fullName));
    slope = [slope data{index,5}];
end

for i = 1:6
    same_group = find([samples{2:end,2}] == i) + 1;
    
    mu(i) = mean(slope(same_group));
    s(i) = std(slope(same_group));
end

means = [mu(1) mu(2) mu(3); mu(4) mu(5) mu(6)]';
std = [s(1) s(2) s(3); s(4) s(5) s(6)]';



barwitherr(std,means)
set(gca,'XTick',[1:3],'XTickLabelMode','manual','XTickLabel',names)
legend('CaCl_2','CuSO_4')

title('Gelling rates for different gelling agents')
xlabel('Gelling agent concentration')
ylabel('Gelling front velocity')
%set(gca,'XTickLabelRotation',90) % add with new matlab


