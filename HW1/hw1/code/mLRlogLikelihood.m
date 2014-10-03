function [ logl ] = mLRlogLikelihood( X, y, W )
    % Filler code, replace with your own.
    logl = 0;
    numSamples = size(X,1);
    numClasses = size(W,1);
    for i=1:numSamples,
        yi = y(i,:);
        Wy = W(yi,:)';
        xi = X(i,:);
        first = xi*Wy;
        
        exponents = zeros(numClasses, 1);
        sum = 0;
        for j=1:numClasses,
             exponents(j,:) = exp(xi*W(j,:)');
             sum = sum + exponents(j,:);
        end
        %log(sum)
        %logSum(exponents)
        logl = logl + (first - log(sum));
    end
end