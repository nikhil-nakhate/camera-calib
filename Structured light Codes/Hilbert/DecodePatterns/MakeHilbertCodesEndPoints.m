
% This function returns the end points of different linear segments of
% Hilbert codes. 
%
% Inputs:
% K: Number of images. For now, treat only K = 4,5
% dim: Dimensionality of the Hilbert curve used. 1<=dim<=K-2. For now,
% treat only dim 2 or 3
% ord: Order of the underlying Hilbert curve. 
% delta: Distance of Hilbert curve arms from edges. Typical value = 0.25


function CodeEndPoints  = MakeHilbertCodesEndPoints(K, dim, ord, delta)             


if(K==4 && dim==2)

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
elseif(K==5 && dim==2)
    
    % Naive permutation matrix
    PermutationMatrix           = [0    0   0   1   1   1   0    0   0   1   1   1  0    0   0   1   1   1  0    0   0   1   1   1  0    0   0   1   1   1  0    0   0   1   1   1  2    2   2   2   2   2  2    2   2   2   2   2  2    2   2   2   2   2  2    2   2   2   2   2;                        
                                   0    1   1   1   0   0   0    1   1   1   0   0  0    1   1   1   0   0  2    2   2   2   2   2  2    2   2   2   2   2  2    2   2   2   2   2  0    0   0   1   1   1  0    0   0   1   1   1  0    0   0   1   1   1  3    3   3   3   3   3;                                 
                                   1    1   0   0   0   1   2    2   2   2   2   2  2    2   2   2   2   2  0    1   1   1   0   0  0    1   1   1   0   0  3    3   3   3   3   3  0    1   1   1   0   0  0    1   1   1   0   0  3    3   3   3   3   3  0    0   0   1   1   1;            
                                   2    2   2   2   2   2   1    1   0   0   0   1  3    3   3   3   3   3  1    1   0   0   0   1  3    3   3   3   3   3  0    1   1   1   0   0  1    1   0   0   0   1  3    3   3   3   3   3  0    1   1   1   0   0  0    1   1   1   0   0;             
                                   3    3   3   3   3   3   3    3   3   3   3   3  1    1   0   0   0   1  3    3   3   3   3   3  1    1   0   0   0   1  1    1   0   0   0   1  3    3   3   3   3   3  1    1   0   0   0   1  1    1   0   0   0   1  1    1   0   0   0   1];              
    
elseif(K==5 && dim==3)
    
    % Naive permutation matrix
    PermutationMatrix           = [0    0   0   0   1   2   2   2   1   2   2   2   1   2   2   2   1   2   2   2;
                                   1    2   2   2   0   0   0   0   2   1   3   3   2   1   3   3   2   1   3   3;
                                   2    1   3   3   2   1   3   3   0   0   0   0   3   3   1   4   3   3   1   4;
                                   3    3   1   4   3   3   1   4   3   3   1   4   0   0   0   0   4   4   4   1;
                                   4    4   4   1   4   4   4   1   4   4   4   1   4   4   4   1   0   0   0   0];
    
end



if(dim==2)
    X                           = hilbert(ord);
elseif(dim==3)
    X                           = hilbert3(ord);
end

% normalizing X
for i=1:size(X,1)
    vecTmp  = X(i,:);
    vecTmp  = (vecTmp - min(vecTmp(:))) / (max(vecTmp(:)) - min(vecTmp(:)));    % normalize to [0,1]
    vecTmp  = vecTmp * (1-2*delta) + delta;                                     % normalize to [delta, 1-delta]
    X(i,:)  = vecTmp;
end

% Putting together X into CodeEndPoints
CodeEndPoints           	= PermMatrixToCodes(PermutationMatrix, X);


