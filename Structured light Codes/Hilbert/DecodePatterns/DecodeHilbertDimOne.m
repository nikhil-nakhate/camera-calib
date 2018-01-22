
% This function performs decoding for data captured using Hilbert codes of
% Dimension 1.
%
% Inputs:
% 1) Data: K x NumPoints matrix, where K is the number of images, and
% NumPoints is the number of pixels. It is assumed that uniform phase
% shifts are captured.
% 2) freq: Modulation frequency.
%
% Outputs:
% 1) IntervalIndices: 1 x NumPoints array --- gives the depth interval of each data point
% 2) Depths: 1 x NumPoints array

function [IntervalIndices, Depths]     = DecodeHilbertDimOne(Data, NumColumns)

Depths                          = zeros(1, size(Data, 2));                          % output variable
K                               = size(Data, 1);                                    % Number of captured images

% Make reduced Gray codes - these are vertices of different intensity segments %
G                               = MakeGrayCodesReduced(K);
NumIntervals                    = size(G,1);                                        % Number of intervals in which the depth range is divided. In each interval, every intensity value varies linearly


%%%%%%%%%%%%%%%% Making interval start and end points %%%%%%%%%%%%%%%%%%%%%

IntervalStartVals               = G';
IntervalEndVals                 = circshift(IntervalStartVals, [0 -1]);
IntervalSlopes                  = IntervalEndVals - IntervalStartVals; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% For each measured intensity vector, identifying the indices corresponding to 0 or 1.
% This is done by finding the intensity that is furthest from the maximum
% and minimum. That intensity is marked as belonging to the slope, whereas
% the rest are marked as constant. 

ValMax                          = max(Data, [], 1);                             % finding the max intensity for every measurement
ValMin                          = min(Data, [], 1);                             % finding the min intensity for every measurement
ValMean                         = (ValMax + ValMin)/2;                          % finding the mean intensity for every measurement
DiffMax                         = abs(repmat(ValMax, [K, 1]) - Data);           % difference from the max intensity  
DiffMin                         = abs(repmat(ValMin, [K, 1]) - Data);           % difference from the min intensity

minDiffFromExtremes             = min(DiffMax, DiffMin);                        % This is the closest distance of each intensity measurement to corresponding extreme (max or min)

[~, NonConstantIndices]         = max(minDiffFromExtremes, [], 1);              % For each intensity vector, this is the index of the element that is furthest from the extremes, and hence, the one that is most likely the non-constant measurement (measurement corresponding to not zero or 1)

% Making a matrix of thresholded data. Its entries are zero if the
% corresponding intensity is likely to correspond to constant zero, it is one if the
% corresponding intensity is likely to correspond to constant one, it is -1
% if the corresponding intensity is likely to correspond to the intensity
% ramp (increasing or decreasing)
DataThresholded                                                     = zeros(size(Data));
DataThresholded(Data > repmat(ValMean, [size(Data, 1), 1]))         = 1;
DataThresholded(Data <= repmat(ValMean, [size(Data, 1), 1]))        = 0;

% Marking the elements corresponding to NonConstantIndices as -1
for i=1:size(Data, 2)
    DataThresholded(NonConstantIndices(i), i)                       = -1;
end


%%%%%%%%%%%%%% Determining the interval number for each data point %%%%%%%%
IntervalIndices                 = zeros(1, size(Data, 2));                      % interval index for each data point

for i=1:NumIntervals
    % intensity indices that are constant for this interval
    ConstIntIndices                         = find(IntervalSlopes(:,i) == 0);
    
    % indices of data points that lie in this interval
    IntMask                                 = ones(1, size(Data,2));
    
    for j=1:numel(ConstIntIndices)
        IntMask                             = IntMask & (DataThresholded(ConstIntIndices(j), :) == IntervalStartVals(ConstIntIndices(j), i));
    end
    
    IntervalIndices(IntMask)                = i;
end

%%% finding and dealing with data points that have not been assigned an interval
DataIndicesNotAssignedInterval           	= find(IntervalIndices == 0);
DataNotAssignedInterval                     = Data(:, DataIndicesNotAssignedInterval);
ValMaxNotAssignedInterval                   = max(DataNotAssignedInterval, [], 1);                             % finding the max intensity 
ValMinNotAssignedInterval               	= min(DataNotAssignedInterval, [], 1);                             % finding the min intensity 
ValMeanNotAssignedInterval              	= (ValMaxNotAssignedInterval + ValMinNotAssignedInterval)/2;       % finding the mean intensity 
DataThresholdedNotAssignedInterval        	= zeros(size(DataNotAssignedInterval));
DataThresholdedNotAssignedInterval(DataNotAssignedInterval > repmat(ValMeanNotAssignedInterval, [size(DataNotAssignedInterval, 1), 1]))         = 1;
DataThresholdedNotAssignedInterval(DataNotAssignedInterval <= repmat(ValMeanNotAssignedInterval, [size(DataNotAssignedInterval, 1), 1]))        = 0;

% for each such data point, finding the nearest vertex
for i=1:numel(DataIndicesNotAssignedInterval)
    tmpData                                                 = DataThresholdedNotAssignedInterval(:, i);
    tmpDiffs                                                = sum((repmat(tmpData, [1 NumIntervals]) - IntervalStartVals).^2, 1);
    [~, minInd]                                             = min(tmpDiffs(:));
    IntervalIndices(DataIndicesNotAssignedInterval(i))      = minInd;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    DepthVals                               = ((i-1) + TVals) / NumIntervals * NumColumns;
    Depths(DataIndsThisInterval)            = DepthVals;
end