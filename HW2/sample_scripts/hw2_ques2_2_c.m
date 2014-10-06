% Homework 2, Question 2, 2.c
%
% Fill in the missing code below!
%
% --- DO NOT ALTER CODE ---


clear all;

p_H_star = 0.6; % the value of the true parameter
sigma_squared = 0.1;  % the variance of the noise term, epsilon_i
p_H = 0:0.01:1; % sample p_H
N_bits = [100 500 1000 2500]; % trial size varies
L = cell(length(N_bits),length(p_H));  % L: num_trial_sizes x num_ph_samples, each row corresponds to the
         % likelihood of one trial size vs. p_H plot
max_L = [];  % max_L: num_trial_sizes x 1, keeps track of the maximum likelihood 
max_L_inds = []; % num_trial_sizes x 1, keeps track of index in p_H with max likelihood
colors = {[0 0 1], [0 1 0], [1 0 0], [0 0 0]}; % colors for the lines

rng(10701); % sets the random seed to produce identical output each time
         

%% FILL IN THE MISSING CODE HERE
%
%  --- ALTER THIS CODE ---
samples = cell(length(N_bits),1);
for i=1:length(N_bits)
   samples{i} = (randn(1,N_bits(i)) >= 0.4) + (randn(1,N_bits(i))*sqrt(sigma_squared));
end

for i=1:length(N_bits)
    samplerow = samples{i};
    for k=1:length(p_H)
        summation = 0;
        ph = p_H(k);
        for j=1:N_bits(i)
            beta = normpdf(samplerow(j)-1.0,0,sigma_squared);
            alpha = normpdf(samplerow(j),0,sigma_squared);
            summation = summation + log(ph*(beta - alpha) + alpha);
        end
        L{i,k} = summation;
    end
end
L







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