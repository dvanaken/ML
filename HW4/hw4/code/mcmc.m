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

actual_probs = [.947, .031, .022];
actual_percentages = actual_probs * 0.01;
probs = [0,0,0];
avg = 0;
bound = 0.01;

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
    
    if abs(probs - actual_probs) < actual_percentages
         %test_runs(j) = i;
         %avg = avg + i;
        
         i
         break;
    end
    if mod(i, 100) == 0
        i 
         abs(probs - actual_probs)
    end
    
end

end

