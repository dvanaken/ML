function [ alpha ] = computeAlpha( eps )
%COMPUTEALPHA 
    alpha = 0.5*log((1-eps)/eps);
end

