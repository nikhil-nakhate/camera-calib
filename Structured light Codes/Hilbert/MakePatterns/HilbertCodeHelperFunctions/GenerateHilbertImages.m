
%%%%%% This script generates projected images corresponding to hilbert
%%%%%% space filling curves. 

clear all; clc; 

projdirname             = ['D:\Current\Optimal Phase Shifting\ProjectedImages\1024x768\SpaceFillingPhaseShifting\Hilbert'];
mkdir(projdirname);

IMin                    = 0.05;         %%% min of the allowed intensity range for projected images
IMax                    = 0.95;         %%% max of the allowed intensity range for projected images
dim                     = 3;            %%% dimension of the hilbert curve
order                   = 2;            %%% order of the hilbert curve

nr                      = 768;          %%% number of rows in the projector
nc                      = 256;         %%% number of columns in the projector

if(dim==2)
    X                       = hilbert(order);
elseif(dim==3)
    X                       = hilbert3(order);
end


%%% Number of line segments
numSegments             = size(X, 2)-1
numPointsPerSegment     = floor( (nc-1) / numSegments)                          %%%% Last point does not belong to any segment. It is a segment of its own. Hence nc-1

%%%% if more points than projector columns, then subsample point
if(nc < size(X, 2))                                                             
    subsampleFactor     = size(X, 2) / nc;
    XInterp     = zeros(dim, nc);
    for i=1:size(X, 1)
        XInterp(i, :)       = interp1([1:size(X, 2)], X(i,:), [1:subsampleFactor:size(X, 2)], 'linear');
    end
    X       = XInterp;
    clear XInterp;
    numSegments             = size(X, 2)-1
    numPointsPerSegment     = floor( (nc-1) / numSegments)                          %%%% Last point does not belong to any segment. It is a segment of its own. Hence nc-1
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

%%%% Making the final points
XFinal                  = zeros(size(X, 1), nc);

%%%% Filling out segments
for i=1:numSegments

    delta           = (X(:, i+1)   - X(:, i)) / numPointsPerSegment;              %%%% Unit vector for this segment
    
    %%% Intermediate points for this segment
    InterPoints     = repmat([0:numPointsPerSegment-1], [size(X, 1), 1]) .* repmat(delta, [1 numPointsPerSegment]);
    
    %%% Placing the points in XFinal
    XFinal(:, (i-1)*numPointsPerSegment+1:i*numPointsPerSegment)    = InterPoints + repmat(X(:, i), [1 size(InterPoints, 2)]);
    
end


%%%% Placing the last point
numPointsLastPoint    = (nc-1) - numPointsPerSegment * numSegments+1       %%%% Last point might have duplicate points
XFinal(:, numPointsPerSegment * numSegments + 1: end)  = repmat(X(:, end), [1 numPointsLastPoint]);


%%%% Normalizing
for i=1:size(XFinal, 1)
    tmp             = XFinal(i, :);
    tmp             = (tmp - min(tmp(:))) / (max(tmp(:)) - min(tmp(:)));
    tmp             = tmp * (IMax - IMin) + IMin;
    XFinal(i, :)    = tmp;
end


%%%% Displaying the curves
if(dim==2)
    figure;plot(X(1,:),X(2,:), 'b.-', 'MarkerSize', 5)
    grid on
    figure;plot(XFinal(1,:),XFinal(2,:), 'b.-', 'MarkerSize', 5)
    grid on
elseif(dim==3)
    figure;plot3(X(1,:),X(2,:),X(3,:), 'b.-', 'MarkerSize', 5)
    grid on
    figure;plot3(XFinal(1,:),XFinal(2,:),XFinal(3,:), 'b.-', 'MarkerSize', 5)
    grid on
end

% ComputeCurveLength(XFinal)
% 
% %%%% Saving the images 
% for i=1:size(XFinal, 1)
%     tmpIm           = repmat(XFinal(i, :), [nr 1]);
%     imname          = [projdirname, '\Dim-', sprintf('%03d', dim), '-Order-', sprintf('%03d', order), '-Image-', sprintf('%03d', i), '.bmp'];
%     imwrite(im2uint8(tmpIm), imname);
%     figure;plot(XFinal(i, :))
% end
% 
% %%% Saving the points
% P       = XFinal;
% save([projdirname, '\Dim-', sprintf('%03d', dim), '-Order-', sprintf('%03d', order), '.mat'], 'P');
% clear P
% 
% ComputeErrorMatrix([XFinal; ones(1, 1024); zeros(1, 1024)], 1, 0.3);
% 
% 
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%% Adding quarter circles to the corners
% blurSize        = 1;
% [XCircle]       = RoundTheCorners(XFinal, numPointsPerSegment, numSegments, blurSize);
% 
% 
% %%%% Displaying the curves
% if(dim==2)
%     figure;plot(X(1,:),X(2,:), 'b.-', 'MarkerSize', 5)
%     figure;plot(XCircle(1,:),XCircle(2,:), 'b.-', 'MarkerSize', 5)
% elseif(dim==3)
%     figure;plot3(X(1,:),X(2,:),X(3,:), 'b.-', 'MarkerSize', 5)
%     figure;plot3(XCircle(1,:),XCircle(2,:),XCircle(3,:), 'b.-', 'MarkerSize', 5)
% end
% 
% ComputeCurveLength(XCircle)
% 
% %%%% Saving the images 
% for i=1:size(XFinal, 1)
%     tmpIm           = repmat(XCircle(i, :), [nr 1]);
%     imname          = [projdirname, '\Dim-', sprintf('%03d', dim), '-Order-', sprintf('%03d', order), '-Circled-BlurSize-', sprintf('%03d', blurSize), '-Image-', sprintf('%03d', i), '.bmp'];
%     imwrite(im2uint8(tmpIm), imname);
%     figure;plot(XCircle(i, :))
% end
% 
% %%% Saving the points
% P   = XCircle;
% save([projdirname, '\Dim-', sprintf('%03d', dim), '-Order-', sprintf('%03d', order), '-Circled-BlurSize-', sprintf('%03d', blurSize), '.mat'], 'P');
% clear P
% 
% ComputeErrorMatrix([XCircle; ones(1, 1024); zeros(1, 1024)], 1, 0.3);
% 
% 
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%% Blurring the images
% blurSize    = 7;
% BlurKernel  = fspecial('gaussian', [1 blurSize], blurSize/5.5);
% for i=1:size(XFinal, 1)
%     XFinal(i, :)    = conv(XFinal(i, :), BlurKernel, 'same');
% end
% 
% 
% %%%% Displaying the curves
% if(dim==2)
%     figure;plot(X(1,:),X(2,:), 'b.-', 'MarkerSize', 5)
%     figure;plot(XFinal(1,:),XFinal(2,:), 'b.-', 'MarkerSize', 5)
% elseif(dim==3)
%     figure;plot3(X(1,:),X(2,:),X(3,:), 'b.-', 'MarkerSize', 5)
%     figure;plot3(XFinal(1,:),XFinal(2,:),XFinal(3,:), 'b.-', 'MarkerSize', 5)
% end
% 
% ComputeCurveLength(XFinal)
% 
% %%%% Saving the images 
% for i=1:size(XFinal, 1)
%     tmpIm           = repmat(XFinal(i, :), [nr 1]);
%     imname          = [projdirname, '\Dim-', sprintf('%03d', dim), '-Order-', sprintf('%03d', order), '-Blurred-BlurSize-', sprintf('%03d', blurSize), '-Image-', sprintf('%03d', i), '.bmp'];
%     imwrite(im2uint8(tmpIm), imname);
%     figure;plot(XFinal(i, :))
% end
% 
% %%% Saving the points
% P   = XFinal;
% save([projdirname, '\Dim-', sprintf('%03d', dim), '-Order-', sprintf('%03d', order), '-Blurred-BlurSize-', sprintf('%03d', blurSize), '.mat'], 'P');
% clear P
% 
% ComputeErrorMatrix([XFinal; ones(1, 1024); zeros(1, 1024)], 1, 0.3);
