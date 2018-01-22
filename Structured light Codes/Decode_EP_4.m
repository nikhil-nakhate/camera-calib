%Data=DecodeHilbertDimTwoThree[EP_Code4_1;EP_Code4_2;EP_Code4_3;EP_Code4_4(1:1920)];
function [Columns]     = Decode_EP_4(Data)
K=4;
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
[r c] =find(DataThresholded==min(DataThresholded(:)));
for i=1:size(r,1)
    if r(i)==1
        label_image(c(i))=1;
    else if r(i)==2
            label_image(c(i))=2;
        else if r(i)==3
                label_image(c(i))=3;
            else if r(i)==4
                    label_image(c(i))=4;
                end
            end
        end
    end
end

Comp{1}= [-1	-1	-1	-1	-1	-1
            0	0	0	1	1	1
            0	1	1	1	0	0
            1	1	0	0	0	1];
        
Comp{2}= [0	0	0	1	1	1
        -1	-1	-1	-1	-1	-1
        0	1	1	1	0	0
        1	1	0	0	0	1];
    
Comp{3}= [1	1	1	0	0	0
        1	0	0	0	1	1
        -1	-1	-1	-1	-1	-1
        0	0	1	1	1	0];
    
Comp{4}= [0	0	0	1	1	1
        1	1	0	0	0	1
        0	1	1	1	0	0
        -1	-1	-1	-1	-1	-1];
    
for i=1:5
    [a]=find(label_image==i);
    for j=1:numel(a)
        for k=1:6
            if (DataThresholded(:,a(j))==Comp{i}(:,k))
%                 value=str2num(strcat(num2str(i),num2str(k)));
                value=k;
                label_sub_image(a(j))=value;
                continue
            end
        end
    end
end

for i=1:4
    if i~=2
        for j=1:6
            [a]=find(label_image==i&label_sub_image==j);
            for k=1:numel(a)
                if mod(j,2)==1
                    Columns(a(k))=(round(((Data(i,a(k))-ValMin(a(k)))/(ValMax(a(k))-ValMin(a(k))))*80)+((j-1)*80))+((i-1)*480);
                else
                    Columns(a(k))=(round(80-((Data(i,a(k))-ValMin(a(k)))/(ValMax(a(k))-ValMin(a(k))))*80)+((j-1)*80))+((i-1)*480);
                end
            end
        end
        
    elseif i==2
        for j=1:6
            [a]=find(label_image==i & label_sub_image==j);
            for k=1:numel(a)
                if mod(j,2)==1
                    Columns(a(k))=(round(80-((Data(i,a(k))-ValMin(a(k)))/(ValMax(a(k))-ValMin(a(k))))*80)+((j-1)*80))+((i-1)*480);
                else
                    
                    Columns(a(k))=(round(((Data(i,a(k))-ValMin(a(k)))/(ValMax(a(k))-ValMin(a(k))))*80)+((j-1)*80))+((i-1)*480);
                end
            end
        end
    end
    
end



        




