function X = hilbert3(n)
% Hilbert 3D curve.
%
% function X = hilbert3(n) gives the vector coordinates of points
% in n-th order Hilbert curve of area 1. size(X, 1) = 3
%
% Example: plot the 3-rd order curve
%
% X = hilbert3(3); plot3(X(1,:), X(2,:), X(3,:))

%   Copyright (c) by Ivan Martynov
%   Inspired by function X = hilbert(n) made by Federico Forte
%   Date: September 17, 2009

if nargin ~= 1
    n = 2;
end

if n <= 0
    X   = zeros(3, 1);
else
    X0          = hilbert3(n-1);
    X(1,:)      = .5*[.5+X0(3,:) .5+X0(2,:) -.5+X0(2,:) -.5-X0(1,:) -.5-X0(1,:) -.5-X0(2,:) .5-X0(2,:) .5+X0(3,:)];
    X(2,:)      = .5*[.5+X0(1,:) .5+X0(3,:) .5+X0(3,:) .5+X0(2,:) -.5+X0(2,:) -.5-X0(3,:) -.5-X0(3,:) -.5-X0(1,:)];
    X(3,:)      = .5*[.5+X0(2,:) -.5+X0(1,:) -.5+X0(1,:) .5-X0(3,:) .5-X0(3,:) -.5+X0(1,:) -.5+X0(1,:) .5-X0(2,:)];
end

