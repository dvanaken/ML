function [sample] = sample_discrete(model, var_id)
%SAMPLE_DISCRETE Samples from the conditional distribution
% of the variable var_id, given that the value of every
% other variable j in the model is 'model{j}.value'.

var = model{var_id};
[probability] = conditional_given_all(model,var_id);
sample = discrete_rnd(model{var_id}.values, probability,1);
end

