function [ mu, sigma ] = NBparameters( X, y )
    % Filler code, replace with your own.
    numFeat = size(X,2);
    numClass = max(y);
    mu = zeros(numClass,numFeat);
    sigma = zeros(numClass,numFeat);
    
    for k = 1:numClass,
        indicators = (y == k);
        for i = 1:numFeat,
            const = 1 / sum(indicators);
            m = X(:,i)' * indicators;
            mu(k,i) = m * const;
            v = (X(:,i) - mu(k,i)).^2;
            v = v' * indicators;
            sigma(k,i) = v * const;
        end
    end
        
end

