% plots all data in database as images
% adds refline
% saves in print_data subfolder


load('Database-management\data.mat')

nFiles = size(data,1);

for n = 2:nFiles
    
    filename = strjoin({'print_data\', data{n,1}, '.jpg'},'');
    
    
    h = plot(data{n,3},data{n,4},'*');
    

    
    refline(data{n,5}, data{n,6});
    title(data(n,1))
    
    saveas(gcf, filename, 'jpg')
end
