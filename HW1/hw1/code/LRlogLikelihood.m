 function [ logl ] = LRlogLikelihood( X, y, w )
    % Filler code, replace with your own.
    numSamples = length(y);
    logl = 0;
    for j=1:numSamples,
        xw = X(j,:)*w;
        logl = logl + y(j,:)*xw - log(1 + exp(xw));
    end
end