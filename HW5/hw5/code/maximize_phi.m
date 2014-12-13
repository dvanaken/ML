function [phi_k] = maximize_phi(words, z, pi, k)
%MAXIMIZE_PHI Compute the arg max of the energy function
% q with respect to phi_k.
%
% inputs:
%   words - A cell array of length D, where each element is
%     a [1 x N_d] vector of words (N_d is the number of
%     words in document d). See 'make_data'.
%   z - A cell array of length D, where each element is a
%     [K x N_d] matrix. Each column of this matrix z_d(:,i)
%     is a vector containing the conditional probability
%     distribution p(z_{di} | w, phi, theta), as returned
%     by 'compute_z_conditional'.
%   pi - A [1 x W] vector containing the Dirichlet prior
%     parameter for phi_k (see handout).
%   k - A scalar indicating the topic k for which to
%     compute the optimal phi_k.
%
% outputs:
%   phi_k - A [1 x W] vector containing the value of phi_k
%     that maximizes the energy function q.

D = length(words); % number of documents
W = length(pi);    % size of dictionary

% TODO: implement me!
phi_k = zeros(1, W);

end

