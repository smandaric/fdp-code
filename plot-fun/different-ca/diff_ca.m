load('ca.mat')

lines_to_plot = [2, 3, 4, 5];

toPlot = [];
names = {};
colors = linspecer(length(lines_to_plot));

for line = [5, 4, 3, 2]
    edge = findEdge(cell2mat(outdata(line,5)),cell2mat(outdata(line,6)),cell2mat(outdata(line,7)),'tresh');
    toPlot = [toPlot, edge'];
    names = [names, outdata(line,1)];
end

newname = {};
for name = names
    temp = cell2mat(name);
    temp = num2str(temp);
    temp = strjoin({'Ca^2^+ =',temp, 'M'},{' ',' '});
    newname = [newname, temp];
end
names = newname;
    


time = cell2mat(outdata(2,7));
    
axes('NextPlot','replacechildren', 'ColorOrder',colors); %
plot(time,toPlot,'LineWidth',2)

title('Edge position')
xlabel('Time [s]')
ylabel('Distance [m]')
h = legend(names);
set(h,'FontSize',10,'Location','southeast')
set(gcf, 'Position', [150 150 640 480])
    