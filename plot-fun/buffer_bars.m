% mops buffer 


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
    '141105-3', 3;    
    '141105-4', 4;
    '141105-8', 5;   
    '141105-9', 6
    
    
    };
    
names = {'Control', 'MOPS pH 7.4', 'MOPS pH 6.5'};



slope = [0];

mu = [];
s = [];

for i = 2:length(samples)
    
    fullName = strjoin({samples{i,1}, '.mat'},'');
    index = find(strcmp(data,fullName));
    slope = [slope data{index,5}];
end

mu= [];
mu(1) = mean(slope(1+1:3+1));
mu(2) = mean(slope(1+4:6+1));
mu(3) = slope(7+1);
mu(4) = slope(8+1);
mu(5) = slope(9+1);
mu(6) = slope(10+1);


means = [mu(1) mu(3) mu(4); mu(2) mu(6) mu(5)];
%std = [s(1) s(2); s(3) s(4)]';



bar(means)
set(gca,'XTick',[1:2],'XTickLabelMode','manual','XTickLabel',{'1 M', '100 mM'})
legend(names)

title('Gelling velocity for buffered and unbuffered gelling solution')
xlabel('Gelling solution concentration')
ylabel('Speed µm/s')
