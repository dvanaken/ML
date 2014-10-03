function [ grad ] = LRgradient( X, y, w )
    % Filler code, replace with your own.
    numFeat = size(X,2);
    grad = zeros(numFeat,1);
    
    % Sum yj - P(yk == 1; x, w)
    numSamples = size(X,1);
    inner = zeros(numSamples,1);
    for j=1:numSamples,
        prob = LRprob(X(j,:),w);
        inner(j,:) = y(j,:) - prob(2,:);
    end
    grad = X' * inner;
    
end