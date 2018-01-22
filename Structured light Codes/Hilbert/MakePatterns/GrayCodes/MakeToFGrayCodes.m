
% Make ToF coding curves based on continuous Gray codes. K is the number of
% images. NDepths is the number of discrete depths (approximately)

function Codes  = MakeToFGrayCodes(K, NDepths)

% Make reduced Gray codes
G                   = MakeGrayCodesReduced(K);
NumSegments         = size(G,1);                                % Number of code segments
PointsPerSegment    = ceil(NDepths/NumSegments);                % Number of points per segment

% Make ToF Codes
Codes               = [];

for i=1:NumSegments
    CodesTmp        = zeros(K, PointsPerSegment);
    iNext           = i+1;
    if(iNext>size(G,1))
        iNext       = mod(iNext, size(G,1));
    end
    for j=1:K
        if(G(i,j)==0 && G(iNext,j)==0)
            CodesTmp(j,:)   = 0;
        elseif(G(i,j)==1 && G(iNext,j)==1)
            CodesTmp(j,:)   = 1;
        elseif(G(i,j)==0 && G(iNext,j)==1)
            CodesTmpVec     = [0:1/PointsPerSegment:1];
            CodesTmp(j,:)   = CodesTmpVec(1:end-1);
        elseif(G(i,j)==1 && G(iNext,j)==0)
            CodesTmpVec     = [1:-1/PointsPerSegment:0];
            CodesTmp(j,:)   = CodesTmpVec(1:end-1);
        end
    end
    Codes   = [Codes CodesTmp];
end