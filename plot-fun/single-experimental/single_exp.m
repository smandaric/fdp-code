% plots all data in database as images
% adds refline
% saves in print_data subfolder


%load('Database-management\data.mat')

n = 51 - 14;

    
h = plot(data{n,3},data{n,4},'*');
    

    
g = refline(data{n,5}, data{n,6});
title(data(n,1))


title('Edge position')
xlabel('Time [s]')
ylabel('Distance [m]')

set(gcf, 'Position', [150 150 640 480])

