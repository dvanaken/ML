function [ H ] = predictAdaBoost( X, alphas, stumps )
%PREDICTADABOOST 
    n = size(X,1);
    
    T = size(stumps,1);
    
    sum = zeros(n, 1);
    for i=1:T
        s = stumps{i};
        sum = sum + alphas(i)*predictWithStump(X,s);
    end
    
    H = sign(sum);
end

