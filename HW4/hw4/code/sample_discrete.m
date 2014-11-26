function [sample] = sample_discrete(model, var_id)
%SAMPLE_DISCRETE Samples from the conditional distribution
% of the variable var_id, given that the value of every
% other variable j in the model is 'model{j}.value'.

% TODO: implement me!
var = model{var_id};
values = var.values;
[probability] = conditional_given_all(model,var_id);
%sample = randi([1, length(values)]) - 1;
sample = discrete_rnd(model{var_id}.values, probability,1);
end

