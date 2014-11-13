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

    alphas = zeros(0,1);
    stumps = cell(0,1);
    
    for i=1:Tmax
        
    end
end

