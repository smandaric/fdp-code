% Runds modl3 for a range of input parameters
% uses techila

tic

cCa = 1;
diffRateMonomer = 1e-11;
Nc = [.3 .4 .5 .6];
k = [10 100 1000 10000];




% Generate cell array containing initial data for gelling parameters:
simData = {'cCa', 'diffRateMonomer', 'Nc', 'k', 'rDist', 'xLabSpace', 'tLabSpace'};

for a = cCa
    for b = diffRateMonomer
        for c = Nc
            for d = k
                simData = [simData; {a, b, c, d, 0, 0, 0}];
            end
        end
    end
end
fprintf(1,'Table of params created! \n');

% dummy variable for holding results in parfor:
dummy = struct;


cloudfor i = 2:length(simData)
%cf:stepsperworker=2
%cf:inputparam=simData, dummy
%cf:force:largedata
%cf:peach LocalCompile=false
%cf:peach RemoteCompile=true
%cf:peach CompilationPlatforms={{'Windows', 'amd64', 'mcc_64'}}     
    
    
    fprintf(1, 'starting loop %d of %d\n', i, length(simData));
    [dummy(i).uLabSpace, dummy(i).xLabSpace, dummy(i).tLabSpace] = modl3(simData{i,1}, simData{i,2}, simData{i,3}, simData{i,4});
    fprintf(1, 'done with loop %d of %d\n', i, length(simData));

    
cloudend


% rearranging data from dummy to simData
fprintf('rearrange all data\n')
for i = 2:length(simData)
    simData{i,5} = dummy(i).uLabSpace;
    simData{i,6} = dummy(i).xLabSpace;
    simData{i,7} = dummy(i).tLabSpace;
end


toc

























