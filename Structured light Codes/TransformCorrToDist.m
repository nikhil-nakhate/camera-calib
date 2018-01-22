
% This function transforms the column correspondence map to scene distances
% using an inverse quadratic map

function [Depths]       = TransformCorrToDist(CorrMap, limVec, a, b, c, minV, maxV, scale, offset)

rowMin      = limVec(1);
rowMax      = limVec(2);
colMin      = limVec(3);
colMax      = limVec(4);

CorrMap   	= CorrMap(rowMin:rowMax, colMin:colMax);

Depths      = (-sqrt(-c - CorrMap) + b) / a;

% normalizing
Depths      = (Depths - minV) / (maxV - minV);
Depths      = Depths * scale + offset;

