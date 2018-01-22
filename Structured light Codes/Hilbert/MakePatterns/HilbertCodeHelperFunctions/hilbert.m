
function X = hilbert(n)
%HILBERT Hilbert curve.
%
% X=hilbert(n) gives the vector coordinates of points
%   in n-th order Hilbert curve of area 1. size(X, 1) = 2
%
% Example: plot of 5-th order curve
%
% X=hilbert(5);line(X(1,:),X(2,:))
%

%   Copyright (c) by Federico Forte
%   Date: 2000/10/06 

if n<=0
  X     =zeros(2, 1);
else
  X0        = hilbert(n-1);
  X(1,:)    =.5*[-.5+X0(2,:) -.5+X0(1,:) .5+X0(1,:)  .5-X0(2,:)];
  X(2,:)    =.5*[-.5+X0(1,:)  .5+X0(2,:) .5+X0(2,:) -.5-X0(1,:)];
end

% X1 = X(1,:);
% X2 = X(2,:);
% 
% X1 = (X1 - min(X1(:))) / (max(X1(:) - min(X1(:))) + eps);
% X2 = (X2 - min(X2(:))) / (max(X2(:) - min(X2(:))) + eps);
% 
% X(1,:) = X1;
% X(2,:) = X2;