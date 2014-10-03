function [ grad ] = mLRgradient( X, y, W )
    % Filler code, replace with your own.
    f = size(X,2);
    numClass = max(y);
    grad = zeros(numClass,f); % grad is now a matrix
    numSamples = size(X,1);
    
    for j=1:numClass,
        for i=1:numSamples,
            xi = X(i,:);
            probs = mLRprob(xi,W);
            yVal = 0;
            if y(i,:) == j
               yVal = 1; 
            end
            grad(j,:) = grad(j,:) + xi * (yVal - probs(j,:));
        end
        
    end
end