
function [Codes, SegmentIndices]  = PermMatrixToCodesForDecoding(PermutationMatrix, XPoints, SubSegmentIndices, NumSubSegments)

K                       = size(PermutationMatrix, 1);
NumSegments             = size(PermutationMatrix, 2);
PointsPerSegment        = size(XPoints,2);                  % redefining PointsPerSegment

Codes                   = [];
SegmentIndices          = [];

for i=1:NumSegments
    CodesTmp        = zeros(K, PointsPerSegment);
    
    for j=1:K
        if(PermutationMatrix(j,i) == 0 || PermutationMatrix(j,i) == 1)
            CodesTmp(j,:)   = PermutationMatrix(j,i);                                                       % constant 0 or 1
        elseif(PermutationMatrix(j,i) == 2 || PermutationMatrix(j,i) == 3 || PermutationMatrix(j,i) == 4)
            CodesTmp(j,:)   = XPoints(PermutationMatrix(j,i)-1,:);                                          % put corresponding Hilbert curves coordinates
        elseif(PermutationMatrix(j,i) == -2 || PermutationMatrix(j,i) == -3 || PermutationMatrix(j,i) == -4)
            CodesTmp(j,:)   = fliplr(XPoints(abs(PermutationMatrix(j,i))-1,:));                             % put corresponding Hilbert curves coordinates in reverse order
        end
    end
    Codes               = [Codes CodesTmp];
    SegmentIndices      = [SegmentIndices, (i-1)*NumSubSegments + SubSegmentIndices];
end