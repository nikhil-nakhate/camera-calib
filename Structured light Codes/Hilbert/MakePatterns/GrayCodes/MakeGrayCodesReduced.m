

% This function makes reduced Gray codes, given the number of bits NBits,
% where the codes with all zeros and all ones are removed. 

function G  = MakeGrayCodesReduced(NBits)

%path(path,'\matgraph')

if(NBits==3 || NBits ==5)           % for these, hamiltonian cycle exists
    % dimensionality
    dim             = NBits;
    
    % generate Gray codes of dim 3
    G               = MakeGrayCodes(dim);                                           % binary matrix
    
    % remove all zeros and all ones
    GSum            = sum(G, 2);
    AllZIn          = find(GSum==0);                                                % Index of all zeros
    AllOIn          = find(GSum==dim);                                              % Index of all ones
    
    G               = G(setdiff([1:size(G,1)], [AllZIn, AllOIn]), :);
    
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
    
    % making graph
    Gr          = graph;
    
    for i=1:size(EdgeList,1)
        add(Gr, EdgeList(i,1), EdgeList(i,2))
        %     ndraw(Gr)
        %     keyboard
        %     close all
    end
    
    [hlist, exists] = hamiltonian_cycle(Gr);
    
    G       = G(hlist, :);

    
elseif(NBits==4 || NBits ==6)           % for these, hamiltonian cycle does not exist. Use cycle for NBits-1
    
    % dimensionality
    dim             = NBits-1;
    
    % generate Gray codes of dim 3
    G               = MakeGrayCodes(dim);                                           % binary matrix
    
    % remove all zeros and all ones
    GSum            = sum(G, 2);
    AllZIn          = find(GSum==0);                                                % Index of all zeros
    AllOIn          = find(GSum==dim);                                              % Index of all ones
    
    G               = G(setdiff([1:size(G,1)], [AllZIn, AllOIn]), :);
    
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
    
    % making graph
    Gr          = graph;
    
    for i=1:size(EdgeList,1)
        add(Gr, EdgeList(i,1), EdgeList(i,2))
        %     ndraw(Gr)
        %     keyboard
        %     close all
    end
    
    [hlist, exists] = hamiltonian_cycle(Gr);
    
    G       = G(hlist, :);
    
    G       = [ [zeros(size(G,1), 1) G]; [ones(size(G,1), 1) flipud(G)] ]; 
    
end