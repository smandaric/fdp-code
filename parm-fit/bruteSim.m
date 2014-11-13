% Runds modl3 for a range of input parameters

tic

cCa = 1;
diffRateMonomer = 1e-11;
Nc = [.4 .5 .6 .7];
k = [1 2 3 4 5 6 7 8 9];


parpool('local',12)

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


parfor i = 2:length(simData)
    fprintf(1, 'starting loop %d of %d\n', i, length(simData));
    [dummy(i).uLabSpace, dummy(i).xLabSpace, dummy(i).tLabSpace] = modl3(simData{i,1}, simData{i,2}, simData{i,3}, simData{i,4});
    fprintf(1, 'done with loop %d of %d\n', i, length(simData));
end

delete(gcp)

% rearranging data from dummy to simData
fprintf('rearrange all data')
for i = 2:length(simData)
    simData{i,5} = dummy(i).uLabSpace;
    simData{i,6} = dummy(i).xLabSpace;
    simData{i,7} = dummy(i).tLabSpace;
end


toc

