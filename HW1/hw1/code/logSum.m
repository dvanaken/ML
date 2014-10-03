function [ sumX ] = logSum( X )
    % Accepts a vector of numbers in logspace and returns the sum of these
    % numbers in logspace.
    maxX = max(X);
    intermediateX1 = X - maxX;
    intermediateX2 = exp(intermediateX1);
    sumX = sum(intermediateX2);
    sumX = log(sumX) + maxX;
end

