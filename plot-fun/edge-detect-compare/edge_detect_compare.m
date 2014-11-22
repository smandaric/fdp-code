%load('modeldata.mat')
%pd = simData(10,:);

pd = outdata(2,:);


edge_tresh = findEdge(cell2mat(pd(5)),cell2mat(pd(6)),cell2mat(pd(7)),'tresh');
edge_deplete = findEdge(cell2mat(pd(5)),cell2mat(pd(6)),cell2mat(pd(7)),'deplete');
edge_slope = findEdge(cell2mat(pd(5)),cell2mat(pd(6)),cell2mat(pd(7)),'slope');

colors = linspecer(3);

time = cell2mat(pd(7));

axes('NextPlot','replacechildren', 'ColorOrder',colors);
plot(time,edge_tresh,time,edge_deplete,time,edge_slope,'LineWidth',2)

title('Edge position')
xlabel('Time [s]')
ylabel('Distance [m]')
h = legend('Treshold','Depletion','Slope');
set(h,'FontSize',10)
set(gcf, 'Position', [150 150 640 480])

