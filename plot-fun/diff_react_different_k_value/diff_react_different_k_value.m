load('modeldata.mat')

plotProfiles(cell2mat(simData(10,5)),cell2mat(simData(10,6)),cell2mat(simData(10,7)),[1 121 241 300],[3],'crop')
hold on
plotProfiles(cell2mat(simData(11,5)),cell2mat(simData(11,6)),cell2mat(simData(11,7)),[1 121 241 300],[3],'crop')
plotProfiles(cell2mat(simData(12,5)),cell2mat(simData(12,6)),cell2mat(simData(12,7)),[1 121 241 300],[3],'crop')
plotProfiles(cell2mat(simData(13,5)),cell2mat(simData(13,6)),cell2mat(simData(13,7)),[1 121 241 300],[3],'crop')
