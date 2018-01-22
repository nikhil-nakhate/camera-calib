
%%%%% This function takes a dimension 2 hilbert curve and increases its
%%%%% dimension by two. This is by no means optimal. 

function X  = IncreaseHilbertDimensionality2to4D(X)

figure;plot(X(1,:))
figure;plot(X(2,:))

keyboard

%%%% Order matrix
M   = [   0   0     0	0	0	0	0	1	1	1	1	1	1;
          0   0     0	1	1	1	1	1	1	0	0	0	1;
          0   1     1	1	1	0	0	0	0	0	1	1	1;
          1   1     0	0	1	1	0	0	1	1	1	0	0];
    
%%%% Change matrix. 0 means no change, 1 means change.       
C   = [   0	0	1	0	0	1	1	0	1	0	1	0
          1	1	1	0	1	0	0	1	1	0	0	1
          1	0	0	1	1	0	1	0	0	1	0	1
          0	1	0	1	0	1	0	1	0	1	1	0];

     
%%%% Normalize X
for i=1:size(X,1)
    tmpVec  = X(i,:);
    minV    = min(tmpVec(:));
    maxV    = max(tmpVec(:));
    tmpVec  = (tmpVec - minV) / (maxV-minV);
    X(i, :) = tmpVec;
end

figure;plot(X(1,:))
figure;plot(X(2,:))
     
XFinal  = zeros(size(M, 1), size(X, 2)*size(C, 2));


for i = 1:size(M, 1)
    for j=1:size(C, 2)
        
        if(M(i,j)==0 && M(i, j+1)==0 && C(i,j)==0)            %%%% 0 and no change
            Vec     = zeros(1, size(X, 2));
        elseif(M(i,j)==1 && M(i, j+1)==1 && C(i,j)==0)        %%%% 1 and no change
            Vec     = ones(1, size(X, 2));
        elseif(M(i,j)==0 && M(i, j+1)==0 && C(i,j)==1)        %%%% remains 0 at both ends but changes
            Vec     = X(2, :);
        elseif(M(i,j)==1 && M(i, j+1)==1 && C(i,j)==1)        %%%% remains 1 at both ends but changes
            Vec     = 1-X(2, :);
        elseif(M(i,j)==0 && M(i, j+1)==1)                    %%%% Changes from 0 to 1
            Vec     = X(1, :);
        elseif(M(i,j)==1 && M(i, j+1)==0)                    %%%% Changes from 1 to 0
            Vec     = fliplr(X(1, :));
        end
        
        XFinal(i, (j-1)*size(X, 2)+1:j*size(X, 2))  = Vec;
        clear Vec
    end
end
    
X   = XFinal;

figure;plot(X(1,:))
figure;plot(X(2,:))
figure;plot(X(3,:))
figure;plot(X(4,:))

keyboard