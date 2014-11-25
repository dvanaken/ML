function [sample] = sample_discrete(model, var_id)
%SAMPLE_DISCRETE Samples from the conditional distribution
% of the variable var_id, given that the value of every
% other variable j in the model is 'model{j}.value'.

% TODO: implement me!
var = model{var_id};
values = var.values;
sample = randi([1, length(values)]) - 1;

end

