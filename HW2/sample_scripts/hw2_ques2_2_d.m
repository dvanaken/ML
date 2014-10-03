% Homework 2, Question 2, 2.d
%
% Fill in the missing code below!

clear all;

p_H_star = 0.6; % the value of the true parameter
sigma_squared = 0.1;  % the variance of epsilon
p_H = 0:0.01:1; % sample p_H
N_bits = [100 500 1000 2500]; %100 250 500 1000]; % trial size varies
L = [];  % L: num_trial_sizes x num_ph_samples, each row corresponds to the
         % likelihood of one trial size vs. p_H plot
max_L = [];  % max_L: num_trial_sizes x 1, keeps track of the maximum likelihood 
max_L_inds = []; % num_trial_sizes x 1, keeps track of index in p_H with max likelihood
colors = {[0 0 1], [0 1 0], [1 0 0], [0 0 0]}; % colors for the lines

p_H_hat = []; % 1 x num_trial_sizes: MLE
p_H_bar = []; % 1 x num_trial_sizes: # O_i > 0.5 / N_bits

rng(10701); % sets the random seed to produce identical output each time
         

%% FILL IN THE MISSING CODE HERE
%
%  --- ALTER THIS CODE ---





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



