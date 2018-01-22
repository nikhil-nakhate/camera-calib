
% This function performs decoding for data captured using Hilbert codes
%
% Inputs:
% 1) Data: K x NumPoints matrix, where K is the number of images, and
% NumPoints is the number of pixels. It is assumed that uniform phase
% shifts are captured.
% 2) freq: Modulation frequency.
% 3) dim: dimension of the Hilbert curve
% 4) ord: order of the Hilbert curve
% 5) delta: distance of Hilbert curve arms from edges (0-1). Typical value = 0.25
% 6) NDepths: length of the projected codes used for finding the interval
% of data points. 
%
% Outputs:
% 1) IntervalIndices: 1 x NumPoints array --- gives the depth interval of each data point
% 2) Depths: 1 x NumPoints array

function [IntervalIndices, Depths]     = DecodeHilbertDimTwoThree(Data, NColumns, dim, ord, delta)

Depths                          = zeros(1, size(Data, 2));                          % output variable

K                               = size(Data, 1);                                    % Number of captured images

% Make code end points - these are vertices of different intensity segments %
CodeEndPoints                   = MakeHilbertCodesEndPoints(K, dim, ord, delta); 

if(K==4 && dim==2)
    NumIntervals                    = 36;
    EndPointsIndices                = setdiff([1:48], [4:4:48]);
elseif(K==5 && dim==2)
    NumIntervals                    = 180;
    EndPointsIndices                = setdiff([1:240], [4:4:240]);
elseif(K==5 && dim==3)
    NumIntervals                    = 140;
    EndPointsIndices                = setdiff([1:160], [8:8:160]);
end

%%%%%%%%%%%%%%%% Making interval start and end points %%%%%%%%%%%%%%%%%%%%%

IntervalStartVals               = CodeEndPoints(:, EndPointsIndices);
IntervalEndVals                 = CodeEndPoints(:, EndPointsIndices+1);
IntervalSlopes                  = IntervalEndVals - IntervalStartVals; 


%%%%%%%%%%%%%%%% Making true codes for comparisons %%%%%%%%%%%%%%%%%%%%%
[TrueCodes, SegmentIndices] 	= MakeToFHilbertCodesForDecoding(K, dim, ord, delta, NColumns);
NColumnsTrue                  	= size(TrueCodes, 2);
% NumTrueCodesPerInterval         = round(NDepths / NumIntervals);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% For each measured intensity vector, identifying the closest TrueCodes
% after normalizing the measured intensity vector. Then, using that to
% determine the interval number for each data point. 

ValMax                          = max(Data, [], 1);                             % finding the max intensity for every measurement
ValMin                          = min(Data, [], 1);                             % finding the min intensity for every measurement
NormalizedData                  = (Data - repmat(ValMin, [K, 1])) ./ repmat(ValMax-ValMin, [K, 1]);

IntervalIndices                 = zeros(1, size(Data, 2));                      % interval index for each data point

for i=1:size(Data, 2)
    [~, minInd]                 = min(sum((TrueCodes - repmat(NormalizedData(:, i), [1 NColumnsTrue])).^2, 1), [], 2);
    IntervalIndices(i)          = SegmentIndices(minInd);
end

%%%%%%%%%%%%%%%%%%% Decoding on an interval-wise basis %%%%%%%%%%%%%%%%%%%%
for i=1:NumIntervals
    DataIndsThisInterval                    = find(IntervalIndices == i);
    
    % selecting the data points that lie in this interval
    DataThisInterval                        = Data(:, DataIndsThisInterval);        
    
    % defining the measurement matrix for this interval
    M                                       = [ones(K,1),   IntervalStartVals(:,i),     IntervalSlopes(:,i)];
    
    % solving the linear system of equations
    XSolve                                  = M \ DataThisInterval;
    
    % solving for phase within this interval (values between 0 and 1)
    TVals                                   = XSolve(3,:) ./ XSolve(2,:);
    DepthVals                               = ((i-1) + TVals) / NumIntervals * NColumnsTrue;
    Depths(DataIndsThisInterval)            = DepthVals;
end