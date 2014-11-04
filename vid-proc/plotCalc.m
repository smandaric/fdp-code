function [rDist, t, rDistRelative] = plotCalc(aMoving, bMoving, frame, vidFPS,sampleType)
% Calculates front movement and time in each frame from ellipse parameters
% and converts to lab space. Assumes the ellipse to be a cricle. Returns
% rDist which is radius at time t


% sets conversion factor according to microscope specified in sampleType
% factor is micrometer per pixel
if strcmp('phase',sampleType)
    factor = 4.1943e-6;   %optical
elseif strcmp('optical',sampleType)
    factor = 6.07e-6; %confocal
end

% Average of the two ellipse axes and subtract radius of first frame.
rDist = factor*((aMoving(1)+bMoving(1))/2 -(aMoving+bMoving)/2);

% Divide by initial radius for relative movement
rDistRelative = 1 - (aMoving+bMoving)/(aMoving(1)+bMoving(1));

% Calculate time of each frame first frame corresponds to t = 0
t = frame/vidFPS - frame(1)/vidFPS;  


end
