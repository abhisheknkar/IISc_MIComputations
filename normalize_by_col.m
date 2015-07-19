function [ A ] = normalize_by_col( A )
%Normalizes an array by column        
    for k = 1:size(A,2)
        col = A(:,k);
        colnorm = (col - mean(col)) / max(eps,std(col));
        A(:,k) = colnorm;
    end
end

