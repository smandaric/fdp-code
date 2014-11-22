% make a movie

load('modeldata.mat')
pd = simData(11,:);

uLabSpace = cell2mat(pd(5));
xLabSpace = cell2mat(pd(6));
tLabSpace = cell2mat(pd(7));

% Edge of bead is where initial calc concentration jumps
beadEdgeIndex = find(diff(uLabSpace(1,:,1)));
       
% Add 10% length to crop area
beadEdgeIndex = round(beadEdgeIndex*1.5);


figure;
fig = gcf;
fig.Position = [230 250 800 600];

%ax.Title.String = 'Concentration profile';
%ax.YLabel.String = 'Concentration [M]';
%ax.XLabel.String = 'Position [mm]';
%ax.NextPlot = 'replacechildren';
%ax.ColorOrder = linspecer(2);




time = [1:301];
loops = 301;
F(loops) = struct('cdata',[],'colormap',[]);
for j = 1:loops
    
    xLabSpaceT = [-fliplr(xLabSpace(2:beadEdgeIndex)),xLabSpace(1:beadEdgeIndex)]*1000;
    uLabSpaceGel = [fliplr(uLabSpace(j,2:beadEdgeIndex,3)), uLabSpace(j,1:beadEdgeIndex,3)];
    uLabSpaceCa = [fliplr(uLabSpace(j,2:beadEdgeIndex,1)), uLabSpace(j,1:beadEdgeIndex,1)];

    [AX l1 l2] = plotyy(xLabSpaceT,uLabSpaceGel,xLabSpaceT,uLabSpaceCa);
    h = text(1.9,0.11,strcat('t =',num2str(j-1),'s'));
    h.FontSize = 14;
    AX(1).YLim = [0 0.12];
    AX(2).YLim = [0 1.2];
    AX(1).YLabel.String = 'Alginate gel concentration [M]';
    AX(2).YLabel.String = 'Ca^2^+ concentration [M]';
    AX(1).Title.String = 'Concentration profile';
    AX(1).XLabel.String = 'Position [mm]';
    AX(1).YTick = [0 .05 .1];
    AX(2).YTick = [0 .5 1];
    AX(1).FontSize = 14;
    AX(2).FontSize = 14;
    drawnow
    F(j) = getframe(fig);
end