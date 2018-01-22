% This function makes reflected Gray codes, given the number of bits NBits

function G  = MakeGrayCodes(NBits)

G   = [0;1];       % initialize to 1-bit codes

for i=2:NBits
    GZero   = [zeros(size(G,1), 1) G];
    GOne    = [ones(size(G,1), 1) G];
    
    G       = [GZero; flipud(GOne)];
end