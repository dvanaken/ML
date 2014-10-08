% Homework 2, Question 2, 2.c
%
% Fill in the missing code below!
%
% --- DO NOT ALTER CODE ---


clear all;

p_H_star = 0.6; % the value of the true parameter
sigma_squared = 1;  % the variance of the noise term, epsilon_i
p_H = 0:0.01:1; % sample p_H
N_bits = [100 500 1000 2500]; % trial size varies
nTrials = length(N_bits);
nPhSamples = length(p_H);
L = zeros(nTrials, nPhSamples);  % L: num_trial_sizes x num_ph_samples, each row corresponds to the
         % likelihood of one trial size vs. p_H plot
max_L = zeros(nTrials, 1);  % max_L: num_trial_sizes x 1, keeps track of the maximum likelihood 
max_L_inds = zeros(nTrials, 1); % num_trial_sizes x 1, keeps track of index in p_H with max likelihood
colors = {[0 0 1], [0 1 0], [1 0 0], [0 0 0]}; % colors for the lines

rng(10701); % sets the random seed to produce identical output each time
         

%% FILL IN THE MISSING CODE HERE
%
%  --- ALTER THIS CODE ---
sigma = sqrt(sigma_squared);
const = 1 / (sigma * sqrt(2 * pi));
for i=1:nTrials
    nBits = N_bits(i);
    samps = (rand(1, nBits) > 0.4) + normrnd(0, sigma, [1 nBits]);
    max_LL = -inf;
    max_LL_ind = 1;
    for j=1:nPhSamples
        ph = .01*(j-1);
        res = 0;
        for k=1:nBits
            samp = samps(1,k);
            beta = const * exp(-(samp-1)^2/(2 * sigma_squared));
            alpha = const * exp(-(samp)^2/(2 * sigma_squared));
            res = res + log(ph * (beta - alpha) + alpha);
        end
        L(i,j) = res;
        if res > max_LL
           max_LL = res;
           max_LL_ind = j;
        end
    end
    max_L(i,1) = max_LL;
    max_L_inds(i,1) = max_LL_ind;
end



%%  Plots the results   --- DO NOT ALTER CODE ---

figure;

for isize = 1:length(N_bits)
    
    plot(p_H, L(isize,:), 'Color', colors{isize});
    hold on;
    plot(p_H(max_L_inds(isize)), max_L(isize), '*', 'MarkerEdgeColor', colors{isize});
    
end

xlabel('p_H');
ylabel('likelihood');
title('2.2.c: blue: 100 trials, green: 500, red: 1000, black: 2500');