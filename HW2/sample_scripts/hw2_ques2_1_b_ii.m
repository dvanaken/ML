% Homework 2, Question 2, 1.b.ii
%
% Fill in the missing code below!
%
% --- DO NOT ALTER CODE ---

clear all;

N_bits = 3;
p_H = 0:0.01:1;  % sample p_H
seqs = {[1 1 1], [1 1 0], [0 0 1], [0 0 0]}; % cell array of observed sequences
L = [];  % L: num_seqs x num_ph_samples, each row corresponds to the
         % likelihood vs. p_H plot
max_L = [];  % max_L: num_seqs x 1, keeps track of the maximum likelihood 
max_L_inds = []; % num_seqs x 1, keeps track of index in p_H with max likelihood
colors = {[0 0 1], [0 1 0], [1 0 0], [0 0 0]}; % colors for the lines
         
%% FILL IN THE MISSING CODE HERE
%
%  --- ALTER THIS CODE ---
numSeqs = length(seqs);
numP_H = length(p_H);
L = zeros(numSeqs, numP_H);
nH = [3, 2, 1, 0];
sum = 0;
for i=1:numSeqs,
    heads = nH(i);
    max_Li = 0;
    max_L_indsi = 1;
    for j=1:numP_H,
        pH = p_H(j);
        L(i,j) = nchoosek(N_bits,heads)*pH^heads*(1-pH)^(N_bits-heads); % Binomial
        % L(i,j) = pH^heads*(1-pH)^(N_bits-heads); % Binomial
        sum = sum + L(i,j)*0.01;
        if L(i,j) > max_Li,
            max_Li = L(i,j);
            max_L_indsi = j;
        end
        max_L(i) = max_Li;
        max_L_inds(i) = max_L_indsi;
    end
end

%%  Plots the results   --- DO NOT ALTER CODE ---

figure;

for iseq = 1:length(seqs)
    
    plot(p_H, L(iseq,:), 'Color', colors{iseq});
    hold on;
    plot(p_H(max_L_inds(iseq)), max_L(iseq), '*', 'MarkerEdgeColor', colors{iseq});
    
end

xlabel('p_H');
ylabel('likelihood');
title('2.1.b.ii: blue: 111, green: 110, red: 001, black: 000');