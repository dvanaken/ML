function [ alphas, stumps ] = trainAdaboostModel( X, Y, Tmax )
%TRAINADABOOSTMODEL 
% Train an Adaboost model with decision stumps. 
%
% Train the model for a number of iterations t. At each iteration i learn 
% a weak learner (stumps{i}) and weight (alphas(i)). For each such weak 
% learner compute its weighted training error eps_t. Stop training if 
% eps_t = 0.5 (for robustness: if eps_i very close to 0.5!), or if the
% maximum number of iterations Tmax was achieved. 
%
% Output: alphas, stumps - arrays of size t where t 
%   is the # of iterations completed before stopping. 

    n = size(Y,1); 
    alphas = zeros(Tmax,1);
    stumps = cell(Tmax,1);
    D = ones(n,1);
    D = (D * 1/n);
    err = 0.5*10e-10;
    
    counter = 0;
    for i=1:Tmax
        % Get stumps
        [ns, fs, xs, gains] = getWeightedInfoGainForStumps(X,Y,D);
        [stump, eps] = chooseBestStump(X,Y,D,fs,xs,gains);
        if eps <=0.5
            break; 
        end
        counter = counter + 1;
        stumps{i} = stump;
        alphas(i,1) = computeAlpha(eps);
        D = computeNewWeights(X,Y,D,alphas(i,1),stump);
    end
    
    stumps = stumps{1:counter};
    alphas = alphas(1:counter);
    
end

