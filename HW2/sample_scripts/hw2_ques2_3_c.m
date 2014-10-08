% Homework 2, Question 2, 3.c
%
% Fill in the missing code below!

clear all;

p_H_star = 0.6; % the value of the true parameter
sigma_squared = [];  % the variance, you'll need to define this (i/2)
p_H = 0:0.01:1; % sample p_H
nPhSamples = length(p_H);
N_bits = [100 500 1000 2500]; % trial size varies
nTrials = length(N_bits);
L = zeros(nTrials, nPhSamples);  % L: num_trial_sizes x num_ph_samples, each row corresponds to the
         % likelihood of one trial size vs. p_H plot
max_L = zeros(nTrials, 1);  % max_L: num_trial_sizes x 1, keeps track of the maximum likelihood 
max_L_inds = zeros(nTrials, 1); % num_trial_sizes x 1, keeps track of index in p_H with max likelihood
colors = {[0 0 1], [0 1 0], [1 0 0], [0 0 0]}; % colors for the lines

p_H_hat = zeros(1, nTrials); % 1 x num_trial_sizes: MLE
p_H_bar = zeros(1, nTrials); % 1 x num_trial_sizes: # O_i > 0.5 / N_bits

rng(10701); % sets the random seed to produce identical output each time
         

%% FILL IN THE MISSING CODE HERE
for i=1:nTrials
    nBits = N_bits(i);
    samps = zeros(1, nBits);
    sigma_squared = zeros(1, nBits);
    for j=1:nBits
        sigma_squared(1, j) = j / nBits;
        samps(1,j) = (rand(1, 1) > 0.4) + normrnd(0, sqrt(sigma_squared(1,j)));
    end
    p_H_bar(1,i) = sum(samps > 0.5) / nBits;
    max_LL = -inf;
    max_LL_ind = 1;
    for j=1:nPhSamples
        ph = .01*(j-1);
        res = 0;
        for k=1:nBits
            samp = samps(1,k);
            const = 1/sqrt(sigma_squared(1,k) * 2 * pi);
            beta = const * exp(-(samp-1)^2/(2 * sigma_squared(1,k)));
            alpha = const * exp(-(samp)^2/(2 * sigma_squared(1,k)));
            res = res + log(ph * (beta - alpha) + alpha);
        end
        L(i,j) = res;
        if res > max_LL
           max_LL = res;
           max_LL_ind = j;
           p_H_hat(1,i) = ph;
        end
    end
    max_L(i,1) = max_LL;
    max_L_inds(i,1) = max_LL_ind;
end




%%  Plots the results 
%   Requires p_H, seqs, and L

figure;

plot(N_bits, p_H_hat, 'Color', colors{1});
hold on;
plot(N_bits, p_H_bar, 'Color', colors{2});

plot([min(N_bits) max(N_bits)], [p_H_star p_H_star], '--k');

ylim([0 1]);
xlabel('trial size');
ylabel('p_H');
title('2.3.c: blue: p-H-hat, green: p-H-bar');



