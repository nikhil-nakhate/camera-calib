
% Normalize Hilbert curves, and expand (place points on them).
% X is the original hilbert curve endpoints
% delta is the gap from the edges
% PointsPerSegment is the number of points to be placed on the curve

function XPoints   = NormalizeAndExpandHilbertCurves(X, delta, PointsPerSegment)

% normalizing
for i=1:size(X,1)
    vecTmp  = X(i,:);
    vecTmp  = (vecTmp - min(vecTmp(:))) / (max(vecTmp(:)) - min(vecTmp(:)));    % normalize to [0,1]
    vecTmp  = vecTmp * (1-2*delta) + delta;                                     % normalize to [delta, 1-delta]
    X(i,:)  = vecTmp;
end

% Number of sub-segments
NumSubSegments      = size(X,2)-1;

% computing length of sub-segments (since they may be unequal)
LengthsSubSegments  = zeros(1,NumSubSegments);
for i=1:NumSubSegments
    LengthsSubSegments(i)   = norm(X(:,i) - X(:,i+1));
end

% Placing points on the sub-segments
XPoints         = [];

for i=1:NumSubSegments
    LengthsSubSegments(i)   = norm(X(:,i) - X(:,i+1));
    NumPointsThisSegment    = ceil(LengthsSubSegments(i) / sum(LengthsSubSegments(:)) * PointsPerSegment);
    XPointsTmp              = zeros(size(X,1), NumPointsThisSegment+1);
    
    for j=1:size(X,1)
        if(X(j,i)== X(j,i+1))
            XPointsTmp(j,:)     = X(j,i)*ones(1,NumPointsThisSegment+1);
        else
            XPointsTmp(j,:)     = [X(j,i): (X(j,i+1) - X(j,i))/NumPointsThisSegment  :X(j,i+1)];
        end
    end
    
    XPointsTmp              = XPointsTmp(:,[1:end-1]);          % removing the last point to avoid duplication
    
    XPoints                 = [XPoints XPointsTmp];
end
    