% can be used to create or updata database of samples



% load text file with interesting samples
fileNames = importdata('Database-management\oct_24.txt');
sampleType = 'optical'; % this must be fixed for confocal results
vidFPS = 1;

% load existing data or create header if no existing database

if exist('Database-management\data.mat','file')
    load('Database-management\data.mat')
else
    data = {'Sample Name', 'Sample Type', 'Time', 'Distance', 'Slope', 'Interscept'};
end


% loop throught each fiel and generate data
for i = 1:length(fileNames)
    sampleName = fileNames{i};
    
    



    sampleData = load(fileNames{i},'aMoving','bMoving','frame');


    % do some plotcalc stuff
    [rDist, t, rDistRelative] = plotCalc(sampleData.aMoving, sampleData.bMoving, sampleData.frame, vidFPS, sampleType);



    % do some linear stuff
    nFrames = length(rDist);
    startFrame = floor(nFrames*.5);
    endFrame = floor(nFrames*.9);
    linearArea = [startFrame:endFrame];


    P = polyfit(t(linearArea),rDist(linearArea),1);

    slope = P(1);
    intersect = P(2);

    newSample = {sampleName, sampleType, t, rDist, slope, intersect}; 

    data = [data; newSample];

end


save('Database-management\data.mat', 'data')


