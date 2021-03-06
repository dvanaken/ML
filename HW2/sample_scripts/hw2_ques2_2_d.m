% Homework 2, Question 2, 2.d
%
% Fill in the missing code below!

clear all;

p_H_star = 0.6; % the value of the true parameter
sigma_squared = 10;  % the variance of epsilon
p_H = 0:0.01:1; % sample p_H
nPhSamps = length(p_H);
N_bits = [100 500 1000 2500]; %100 250 500 1000]; % trial size varies
nTrials = length(N_bits);
L = zeros(nTrials, nPhSamps);  % L: num_trial_sizes x num_ph_samples, each row corresponds to the
         % likelihood of one trial size vs. p_H plot
max_L = zeros(nTrials, 1);  % max_L: num_trial_sizes x 1, keeps track of the maximum likelihood 
max_L_inds = zeros(nTrials, 1); % num_trial_sizes x 1, keeps track of index in p_H with max likelihood
colors = {[0 0 1], [0 1 0], [1 0 0], [0 0 0]}; % colors for the lines

p_H_hat = zeros(1, nTrials); % 1 x num_trial_sizes: MLE
p_H_bar = zeros(1, nTrials); % 1 x num_trial_sizes: # O_i > 0.5 / N_bits

rng(10701); % sets the random seed to produce identical output each time
         

%% FILL IN THE MISSING CODE HERE
%
%  --- ALTER THIS CODE ---
sigma = sqrt(sigma_squared);
const = 1 / (sigma * sqrt(2 * pi));
for i=1:nTrials
    nBits = N_bits(i);
    %samps = (rand(1, nBits) > 0.4) + normrnd(0, sigma, [1 nBits]);
    samps = (binornd(1, 0.6, 1, nBits)) + normrnd(0, sigma, [1 nBits]);
    p_H_bar(1,i) = sum(samps > 0.5) / nBits;
    max_LL = -inf;
    max_LL_ind = 1;
    for j=1:nPhSamps
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
           p_H_hat(1,i) = ph;
        end
    end
    max_L(i,1) = max_LL;
    max_L_inds(i,1) = max_LL_ind;
end




%%  Plots the results   --- DO NOT ALTER CODE ---

figure;

plot(N_bits, p_H_hat, 'Color', colors{1});
hold on;
plot(N_bits, p_H_bar, 'Color', colors{2});

plot([min(N_bits) max(N_bits)], [p_H_star p_H_star], '--k');

ylim([0 1]);
xlabel('trial size');
ylabel('p_H');
title('2.2.d: blue: p-H-hat, green: p-H-bar');



