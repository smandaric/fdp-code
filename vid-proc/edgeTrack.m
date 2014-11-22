function edgeTrack
%Semi-automated process for detecting gelling front
% Input is a greyscale video.

% Input parameters
videoName = 'examplevid';
tresh = .05; % treshold for edge detection 
nFramesToAnalyze = 25; % how many frames you want to analyse

% Generating path for input and output. Check that folders are ok
videoInputPath = strcat('D:\vidproc\proc\',videoName,'.avi');
outputPath = strcat('C:\Users\Stefan\Dropbox\Fag\FDP\importedVids\',videoName,'.mat');



fprintf(1,'Importing video...\n');
vidObj = VideoReader(videoInputPath);
nFramesTot = vidObj.NumberOfFrames;
vidFPS = vidObj.FrameRate;
img = read(vidObj);
fprintf(1,'Done!\n');



% selects which frames to analyze, selection must be greater than say.. 20
% initialFrames = 1:2:9;
% nonlinearFrames = linspace(11,nFramesTot/2,floor(nFramesToAnalyze/2));
% linearFrames =  linspace(floor(nFramesTot/2 + nFramesTot/(2*(nFramesToAnalyze/2-5))), nFramesTot, floor(nFramesToAnalyze/2-5));
% frame = [initialFrames floor(nonlinearFrames) floor(linearFrames)]; %sammenbles frames to one vector

% this one is better for the manual ones
frame = floor(linspace(1,nFramesTot,nFramesToAnalyze));



% Pre-allocating memory
[H,W,~] = size(img);
nFrames = size(frame,2);                                                
fused = zeros(H,W,3,nFrames,'uint8');
aMoving = zeros(1,nFrames);
bMoving = zeros(1,nFrames);
zMoving = zeros(2,nFrames); 
alphaMoving = zeros(1,nFrames);
BW = zeros(H,W,1,nFrames,'uint8');


for n = 1:nFrames
    BW(:,:,n) = edge(img(:,:,frame(n)),'canny',tresh);
    fprintf(1,'Edge detect frame %d of %d\n',frame(n), frame(end));
end
fprintf(1,'Done!');


BW = BW>0;
isStaticEdge = mean(BW,4) > .1; %.05 to .1 for 70-100 frames filters out static edges

fprintf(1,'Manual for first frame\n');
imshow(uint8(img(:,:,1,1)),'InitialMagnification','fit')
[y, x] = ginput; %%% nb nb
x = floor(x);
y = floor(y);
[z, a, b, alpha] = fitellipse([x y], 'linear'); % produces error if less than 6 points selected
aMoving(1) = a;
bMoving(1) = b;
zMoving(:,1) = z;
alphaMoving(1) = alpha;

ellipse = drawEllipse(a,b,z,alpha,H,W);
fused(:,:,:,1) = uint8(imfuse(img(:,:,1,frame(1)),ellipse));


BWthinSave = {}; %%%%%%%%

for n = 2:nFrames
    fprintf(1,'Processing frame %d of %d\n',frame(n), frame(end));
    aExpectedRange = [aMoving(n-1)-30 aMoving(n-1)+10]; 
    bExpectedRange = [bMoving(n-1)-30 bMoving(n-1)+10];
    
    mExpected = (drawEllipse(aExpectedRange(1),bExpectedRange(1),zMoving(:,n-1),alphaMoving(n-1),H,W)+drawEllipse(aExpectedRange(2),bExpectedRange(2),zMoving(:,n-1),alphaMoving(n-1),H,W)) > 0;
        
    centralEl = drawEllipse(aMoving(n-1),bMoving(n-1),zMoving(:,n-1),alphaMoving(n-1),H,W);
    [rowEl, colEl] = find(centralEl, 1, 'first');
    rowEl = floor(rowEl);
    colEl = floor(colEl);
        
    mExpected = imfill(mExpected,[rowEl colEl]);
    BWfiltered = and(BW(:,:,1,n),mExpected);
    BWthin = bwmorph(BWfiltered,'thin'); % thin borders
    BWthin = bwareaopen(BWthin, 40);
    [col, row] = find(BWthin);
    
    BWthinSave = [BWthinSave, BWthin]; %%%%%%%%%%
    
    if length(col) > 1000                      % to prevent memory overflow
        q = floor(linspace(1,length(col),1000));
        x = [col(q)'; row(q)'];
    else
        x = [col'; row'];
    end
    
    try
        [z, a, b, alpha] = fitellipse(x, 'linear');
        ellipse = drawEllipse(a,b,z,alpha,H,W);
        fusedTEMP = imfuse(img(:,:,1,frame(n)),ellipse);
    catch err
        fprintf(1,'Unable to fit ellipse to data in frame %d\n',n);
        fusedTEMP = img(:,:,1,frame(n));
    end


    
    while 1
        imshow(uint8(fusedTEMP),'InitialMagnification','fit')
        [y, x] = ginput;
        x = floor(x);
        y = floor(y);
        
        if length(x) < 6
            break
        end
        
        [z, a, b, alpha] = fitellipse([x y], 'linear'); % error my still be produced
        ellipse = drawEllipse(a,b,z,alpha,H,W);
        fusedTEMP = imfuse(img(:,:,1,frame(n)),ellipse);
    end
    
    aMoving(n) = a;
    bMoving(n) = b;
    zMoving(:,n) = z;
    alphaMoving(n) = alpha;
    fused(:,:,:,n) = uint8(fusedTEMP); %%%5 add for fist one as well
end

save(outputPath,'fused', 'aMoving','bMoving', 'zMoving', 'alphaMoving', 'frame', 'vidFPS','img','BW','BWthinSave')   % removed save of img to save room

% Plot edge position
[rDist, t, ~] = plotCalc(aMoving, bMoving, frame, vidFPS, 'optical');
plot(t,rDist,'*')

end
