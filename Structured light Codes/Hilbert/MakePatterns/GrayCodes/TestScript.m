
clear all;
clc
path(path,'./matgraph')

% dimensionality 
dim             = 5;

% generate Gray codes of dim 3
G               = MakeGrayCodes(dim);                                           % binary matrix

% remove all zeros and all ones
GSum            = sum(G, 2);
AllZIn          = find(GSum==0);                                                % Index of all zeros
AllOIn          = find(GSum==dim);                                              % Index of all ones

G               = G(setdiff([1:size(G,1)], [AllZIn, AllOIn]), :)

% make the set of edges
EdgeList        = [];
for i=1:size(G,1)
    for j=i+1:size(G,1)
        HammingDistance     = sum(abs(G(i,:) - G(j,:)));
        if(HammingDistance==1)
            EdgeList    = [EdgeList; [i j]];
        end
    end
end

EdgeList

% making graph
Gr          = graph

for i=1:size(EdgeList,1)
    add(Gr, EdgeList(i,1), EdgeList(i,2))
%     ndraw(Gr)
%     keyboard
%     close all
end

[hlist, exists] = hamiltonian_cycle(Gr)

GrayCodes       = G(hlist, :)
% cycles  =   grCycleBasis(EdgeList)
% sum(cycles,1)