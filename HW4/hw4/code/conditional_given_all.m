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
probability = ones(1, length(model{var_id}.values));
probability = probability / sum(probability);

var = model{var_id};
var
model{1}
var_parents = conditional_given_parents(model,var_id);

product = 1;
for i=1:length(var.children)
    child_id = var.children(i);
    child = model{child_id};
    child
    c_parents = conditional_given_parents(model, child_id);
    c_prob = c_parents(child.value + 1);
    product = product * c_prob;
end

probability = var_parents .* product;

end

