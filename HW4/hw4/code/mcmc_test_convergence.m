function [model] = mcmc(model, observed_variables, observed_values, iterations)
%MCMC Runs a number of iterations of Gibbs sampling on the
% given model, with specified observations.
%
% inputs:
%   model - A cell array of random variable structs,
%     potentially with uninitialized fields 'observed',
%     'value', and 'samples'.
%   observed_variables - A vector of IDs (indices)
%     indicating which random variables in 'model' are
%     observed.
%   observed_values - A vector containing the observed
%     values (parallel to 'observed_variables').
%   iterations - The number of iterations to run.
%
% outputs:
%   model - The modified cell array where each unknown
%     variable struct contains a list of T samples.

[unknown_variables, model] = init_mcmc( ...
    model, observed_variables, observed_values, iterations);

bound = 0.01;
actual_probs = [.947, .031, .022];
actual_percentages = actual_probs * bound;
probs = [0,0,0];

for i = 1:iterations
	perm = randperm(length(unknown_variables));
    
    for j=1:length(unknown_variables)
        id = unknown_variables(perm(j));
        newval = sample_discrete(model, id);
        model{id}.samples(i) = newval;
        model{id}.value = newval;
    end
    
    probs(1) = sum(model{1}.samples(1:i) == 0)/i;
    probs(2) = sum(model{1}.samples(1:i) == 1)/i;
    probs(3) = sum(model{1}.samples(1:i) == 2)/i;
    
    error(1) = abs((probs(1) - actual_probs(1)) / actual_probs(1));
    error(2) = abs((probs(2) - actual_probs(2)) / actual_probs(2));
    error(3) = abs((probs(3) - actual_probs(3)) / actual_probs(3));
    
    sum_below = sum(error < bound);
    
    %if abs(probs - actual_probs)/ < actual_percentages
    if sum_below == 3
         %test_runs(j) = i;
         %avg = avg + i;
         error
         probs
         i
         break;
    end
    if mod(i, 100) == 0
        i 
        error
         probs
    end
    
end

end

