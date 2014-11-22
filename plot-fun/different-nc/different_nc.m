%load('nc.mat')


edge_4 = findEdge(cell2mat(outdata(2,5)),cell2mat(outdata(2,6)),cell2mat(outdata(2,7)),'tresh');
edge_45 = findEdge(cell2mat(outdata(3,5)),cell2mat(outdata(3,6)),cell2mat(outdata(3,7)),'tresh');
edge_5 = findEdge(cell2mat(outdata(4,5)),cell2mat(outdata(4,6)),cell2mat(outdata(4,7)),'tresh');
edge_55 = findEdge(cell2mat(outdata(5,5)),cell2mat(outdata(5,6)),cell2mat(outdata(5,7)),'tresh');
edge_6 = findEdge(cell2mat(outdata(6,5)),cell2mat(outdata(6,6)),cell2mat(outdata(6,7)),'tresh');

toPlot = [edge_4', edge_45',edge_5',edge_55',edge_6'];

colors = linspecer(5);

time = cell2mat(outdata(2,7));

axes('NextPlot','replacechildren', 'ColorOrder',colors); %
plot(time,toPlot,'LineWidth',2)

title('Edge position')
xlabel('Time [s]')
ylabel('Distance [m]')
h = legend('N_c = .4','N_c = .45','N_c = .5','N_c = .55','N_c = .6');
set(h,'FontSize',10,'Location','southeast')
set(gcf, 'Position', [150 150 640 480])
