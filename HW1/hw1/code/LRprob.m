function [ p ] = LRprob( x, w )
    % Filler code, replace with your own.
    p = zeros(2,1);
    p(1,:) = 1/(1+exp(x*w)); 
    p(2,:) = 1 - p(1,:);
end