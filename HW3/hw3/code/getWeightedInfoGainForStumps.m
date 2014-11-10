function [ ns, fs, xs, gains ] = getWeightedInfoGainForStumps( X, Y, D )
%GETWEIGHTEDINFOGAINFORSTUMPS Compute the weighted info gain 
% for every possible split along every possible dimension. 
% 
% Output: 
% A list of ns splits and associated gains, each split i described via:
%   fs(i) - the feature along which we split
%   xs(i) - the value according to which we split Xi <= xs(i), Xi > xs(i)
%   gains(i) - the information gain obtained by splitting acording to fs(i), xs(i)
% fs, xs, gains are vectors of equal size (ns x 1), equal to the
% total # of distinct splits. 
% 
% NOTE: "All possible splits along dimension i" = all splits obtained by 
% sorting X according to coordinate i, and taking the midpoint 
% between each two consecutive distinct points. As not all points may be 
% distinct, the total # of splits ns migth be < n*k. 

    n = size(X,1);
    k = size(X,2);
    ns = 0;
    
    % Pre-allocate max memory we might need for efficiency 
    fs = zeros((n-1)*k,1); 
    xs = zeros((n-1)*k,1);
    gains = zeros((n-1)*k,1);
    
    
    % TODO: Fill in your code here! 
    % -----------------------------
    % Calculate marginal entropy H(y)
    % Calculate matrix of conditional entropies H(Y | Xi)
    % Gain = difference in entropies H(y) - H(y | Xi)
    
    
    % Only return the ns splits (remove zero padding we pre-allocated)
    fs = fs(1:ns);
    xs = xs(1:ns);
    gains = gains(1:ns);
end

