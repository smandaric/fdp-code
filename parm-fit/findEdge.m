function [rEdge] = findEdge(uLabSpace,xLabSpace,tLabSpace,method)

frontIndex = zeros(1,length(tLabSpace));
initialconc = uLabSpace(1,1,2);

switch method
    case 'tresh'  % finds a value at z=3 above treshhold which is half of initial
        
        
        for i = 1:length(tLabSpace)
            index = find(uLabSpace(i,:,3)>initialconc/2, 1, 'first'); % for each timepoint, find first index of first concentration above treshhold. Returns empty if no value above treshhold
            
            if isempty(index)
                frontIndex(i) = find(uLabSpace(1,:,2)<.1, 1, 'first') -1 ; % If frontIndex is empty, front is still at initial position, and has moved 0 distance
            else
                frontIndex(i) = index;
            end
        end
    case 'deplete' % dip in sum of z2+z3
        
        gelEdge = find(uLabSpace(1,:,2)<initialconc, 1, 'first') -1 ;
        
        for i = 1:length(tLabSpace)
            gelConc = uLabSpace(i,1:gelEdge,2)+uLabSpace(i,1:gelEdge,3);
            
            peakIndex = find(gelConc == max(gelConc), 1, 'first');
            if isempty(peakIndex) || peakIndex == 1
                peakIndex = gelEdge;
            end
            
            
            index = find(gelConc(1:peakIndex) == min(gelConc(1:peakIndex)), 1, 'first');
            
            
            
            if isempty(index) || index == 1
                frontIndex(i) = gelEdge ; % If frontIndex is empty, front is still at initial position, and has moved 0 distance
            else
                frontIndex(i) = index;
            end
            
            frontIndex(diff(frontIndex)>1.5e-4) = gelEdge; % very high change - > initial
            
        end
    
    case 'slope'
        gelEdge = find(uLabSpace(1,:,2)<initialconc, 1, 'first') -1 ;
        uLabSpace = uLabSpace(:,1:gelEdge,3);
        
        for i = 1:length(tLabSpace)
            df = diff(uLabSpace(i,:));
            df = df(df > 0);
            
            index = find(df == max(df),1, 'first');
            
            if isempty(index)
                frontIndex = gelEdge;
            else
                frontIndex(i) = index;
            end
            
        end
end

           
            
        
        
        
        
rEdge = - xLabSpace(frontIndex) + xLabSpace(frontIndex(1));

end
