
% Make patterns based on Hilbert curves. 
% K is the number of images. 
% dim is the dimensionality of the Hilbert curve used. dim=1 means just Gray coded ToF. 1<=dim<=K-2
% ord is the order of the underlying Hilbert curve. 
% delta is the distance of Hilbert curve arms from edges. Typical value = 0.25
% NDepths is the number of discrete depths (approximately)


function Codes  = MakeHilbertCodes(K, dim, ord, delta, NDepths)             


if(dim==1)      % continuous Gray codes based coding
    Codes   = MakeToFGrayCodes(K, NDepths);
    
elseif(K==4 && dim==2)

%     % Naive permutation matrix
%     PermutationMatrix           = [1    1   1   2   2   0   0   2   2   0   2   2;
%                                    0    2   2   1   1   1   2   0   3   2   0   3;
%                                    2    0   3   0   3   2   1   1   1   3   3   0;
%                                    3    3   0   3   0   3   3   3   0   1   1   1];               % 0 means all zeros, 1 means all ones, 2 means first Hilbert coordiante, 3 means second Hilbert coordinate, negatives means the corresponding Hilbert coordinates in the reverse order
    
    % Designed permutation matrix
    PermutationMatrix           = [0    0   2   1   1   -2  1   -2  3   0   2   -2;
                                   2    1   3   -3  0   -3  -3  1   1   -2  0   0;
                                   3    -3  1   -2  2   0   0   0   2   1   1   -3;
                                   1    -2  0   0   3   1   -2  -3  0   -3  3   1];                 % 0 means all zeros, 1 means all ones, 2 means first Hilbert coordiante, 3 means second Hilbert coordinate, negatives means the corresponding Hilbert coordinates in the reverse order
    
    
    NumSegments                 = size(PermutationMatrix, 2);
    PointsPerSegment            = ceil(NDepths/NumSegments);            % Number of points per segment
    X                           = hilbert(ord);
    XPoints                     = NormalizeAndExpandHilbertCurves(X, delta, PointsPerSegment);
    Codes                       = PermMatrixToCodes(PermutationMatrix, XPoints);
    
    
elseif(K==5 && dim==2)
    
    % Naive permutation matrix
    PermutationMatrix           = [0    0   0   1   1   1   0    0   0   1   1   1  0    0   0   1   1   1  0    0   0   1   1   1  0    0   0   1   1   1  0    0   0   1   1   1  2    2   2   2   2   2  2    2   2   2   2   2  2    2   2   2   2   2  2    2   2   2   2   2;                        
                                   0    1   1   1   0   0   0    1   1   1   0   0  0    1   1   1   0   0  2    2   2   2   2   2  2    2   2   2   2   2  2    2   2   2   2   2  0    0   0   1   1   1  0    0   0   1   1   1  0    0   0   1   1   1  3    3   3   3   3   3;                                 
                                   1    1   0   0   0   1   2    2   2   2   2   2  2    2   2   2   2   2  0    1   1   1   0   0  0    1   1   1   0   0  3    3   3   3   3   3  0    1   1   1   0   0  0    1   1   1   0   0  3    3   3   3   3   3  0    0   0   1   1   1;            
                                   2    2   2   2   2   2   1    1   0   0   0   1  3    3   3   3   3   3  1    1   0   0   0   1  3    3   3   3   3   3  0    1   1   1   0   0  1    1   0   0   0   1  3    3   3   3   3   3  0    1   1   1   0   0  0    1   1   1   0   0;             
                                   3    3   3   3   3   3   3    3   3   3   3   3  1    1   0   0   0   1  3    3   3   3   3   3  1    1   0   0   0   1  1    1   0   0   0   1  3    3   3   3   3   3  1    1   0   0   0   1  1    1   0   0   0   1  1    1   0   0   0   1];              
    
    NumSegments                 = size(PermutationMatrix, 2);
    PointsPerSegment            = ceil(NDepths/NumSegments);            % Number of points per segment
    X                           = hilbert(ord);
    XPoints                     = NormalizeAndExpandHilbertCurves(X, delta, PointsPerSegment);
    Codes                       = PermMatrixToCodes(PermutationMatrix, XPoints);

    
elseif(K==5 && dim==3)
    
    % Naive permutation matrix
    PermutationMatrix           = [0    0   0   0   1   2   2   2   1   2   2   2   1   2   2   2   1   2   2   2;
                                   1    2   2   2   0   0   0   0   2   1   3   3   2   1   3   3   2   1   3   3;
                                   2    1   3   3   2   1   3   3   0   0   0   0   3   3   1   4   3   3   1   4;
                                   3    3   1   4   3   3   1   4   3   3   1   4   0   0   0   0   4   4   4   1;
                                   4    4   4   1   4   4   4   1   4   4   4   1   4   4   4   1   0   0   0   0];
    
    NumSegments                 = size(PermutationMatrix, 2);
    PointsPerSegment            = ceil(NDepths/NumSegments);            % Number of points per segment
    X                           = hilbert3(ord);
    XPoints                     = NormalizeAndExpandHilbertCurves(X, delta, PointsPerSegment);
    Codes                       = PermMatrixToCodes(PermutationMatrix, XPoints);
end

