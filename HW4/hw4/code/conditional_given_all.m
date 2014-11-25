function [probability] = conditional_given_all(model, var_id)
%CONDITIONAL_GIVEN_ALL Computes the conditional
% distribution of the variable var_id given all other
% variables.
%
% inputs:
%   model - A cell array of random variable structs.
%   var_id - The ID of the variable for which to compute
%     the conditional distribution.
%
% output:
%   probability - A [1 x k] vector where k = length(
%     model{var_id}.values)). The element at i should be
%     the conditional probability that the variable var_id
%     is equal to the ith outcome, given that the value of
%     every other variable j in the model is
%     'model{j}.value'.

% TODO: implement me!
num_values = length(model{var_id}.values);
probability = ones(1, num_values);


var = model{var_id};
var_parents = conditional_given_parents(model,var_id);

for i=1:num_values
    var.value = i - 1;
    prob = 1;
    for j=1:length(model)
        if j ~= var_id
        node = model{j};
        n_parents = conditional_given_parents(model, j);
        prob = prob * n_parents(node.value + 1);
        end
    end
    probability(i) = var_parents(i) * prob;
end

% product = 1;
% for i=1:length(var.children)
%    child_id = var.children(i);
%     child = model{child_id};
%     c_parents = conditional_given_parents(model, child_id);
%     c_prob = c_parents(child.value + 1);
%     product = product * c_prob;
% end

% probability = var_parents .* product;
probability
probability = probability / sum(probability);
end

