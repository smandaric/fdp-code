function [rEdge] = findEdge(uLabSpace,xLabSpace,tLabSpace,method)

frontIndex = zeros(1,length(tLabSpace));

switch method
    case 'tresh'

        for i = 1:length(tLabSpace)
            index = find(uLabSpace(i,:,3)>.1/2, 1, 'first'); % for each timepoint, find first index of first concentration above treshhold. Returns empty if no value above treshhold
            
            if isempty(index)
                frontIndex(i) = find(uLabSpace(1,:,2)<.1, 1, 'first') -1 ; % If frontIndex is empty, front is still at initial position, and has moved 0 distance
            else
                frontIndex(i) = index;
            end
        end
    case 'deplete'
        
        gelEdge = find(uLabSpace(1,:,2)<.1, 1, 'first') -1 ;
        
        for i = 1:length(tLabSpace)
            gelConc = uLabSpace(i,1:gelEdge-5,2)+uLabSpace(i,1:gelEdge-5,3);
            
            index = find(gelConc == min(gelConc), 1, 'first');
            
            if isempty(index) || index == 1
                frontIndex(i) = gelEdge ; % If frontIndex is empty, front is still at initial position, and has moved 0 distance
            else
                frontIndex(i) = index;
            end
        end
end      
        
rEdge = - xLabSpace(frontIndex) + xLabSpace(frontIndex(1));

end
