% Homework 2, Question 2, 3.b
%
% Fill in the missing code below!

clear all;

p_H_star = 0.6; % the value of the true parameter
sigma_squared = [];  % the variance, you'll need to define this (i/N_bits)
p_H = 0:0.01:1;  % sample p_H
N_bits = [100 500 1000 2500]; % trial size varies
L = [];  % L: num_trial_sizes x num_ph_samples, each row corresponds to the
         % likelihood of one trial size vs. p_H plot
max_L = [];  % max_L: num_trial_sizes x 1, keeps track of the maximum likelihood 
max_L_inds = []; % num_trial_sizes x 1, keeps track of index in p_H with max likelihood
colors = {[0 0 1], [0 1 0], [1 0 0], [0 0 0]}; % colors for the lines

rng(10701); % sets the random seed to produce identical output each time
         

%% FILL IN THE MISSING CODE HERE
%
%  --- ALTER THIS CODE ---






%%  Plots the results   --- DO NOT ALTER CODE ---

figure;

for isize = 1:length(N_bits)
    
    plot(p_H, L(isize,:), 'Color', colors{isize});
    hold on;
    plot(p_H(max_L_inds(isize)), max_L(isize), '*', 'MarkerEdgeColor', colors{isize});
    
end

xlabel('p_H');
ylabel('likelihood');
title('2.3.b: blue: 100 trials, green: 500, red: 1000, black: 2500');


