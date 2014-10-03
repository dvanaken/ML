function [ probs ] = NBprior( y )
    probs = accumarray(y, 1);
    probs = probs / length(y);
end

