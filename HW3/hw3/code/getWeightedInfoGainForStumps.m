function [ ns, fs, xs, gains ] = getWeightedInfoGainForStumps( X, Y, D )
%GETWEIGHTEDINFOGAINFORSTUMPS Compute the weighted info gain 
% for every possible split along every possible dimension. 
% 
% Output: 
% A list of ns splits and associated gains, each split i described via:
%   fs(i) - the feature along which we split
%   xs(i) - the value according to which we split Xi <= xs(i), Xi > xs(i)
%   gains(i) - the information gain obtained by splitting acording to fs(i), xs(i)
% fs, xs, gains are vectors of equal size (ns x 1), equal to the
% total # of distinct splits. 
% 
% NOTE: "All possible splits along dimension i" = all splits obtained by 
% sorting X according to coordinate i, and taking the midpoint 
% between each two consecutive distinct points. As not all points may be 
% distinct, the total # of splits ns migth be < n*k. 

%     X = [0.1, 0.5, 1.1, 1.9, 2.6, 3.5, 4.5]';
%     Y = [ -1,   1,   1,  -1,  -1,   1,  -1]';
%     D = [0.1, 0.2, 0.1, 0.1, 0.3, 0.1, 0.1]';

    function logm = entropy(x)
        if x == 0
            logm = 0; 
        else
            logm = x*log2(x);
        end
    end

    %X = [2.6, 0.1, 3.5, 1.1, 1.1 ; 2.1, 3.4, 0.5, 0.1, 2.2]';
    %Y = [ -1,  -1,   1,  -1,  -1]';
    %D = [0.3, 0.1, 0.2, 0.3, 0.1]';

    n = size(X,1);
    k = size(X,2);
    ns = 0;
    
    % Pre-allocate max memory we might need for efficiency 
    fs = zeros((n-1)*k,1); 
    xs = zeros((n-1)*k,1);
    gains = zeros((n-1)*k,1);
    
    % TODO: Fill in your code here! 
    % -----------------------------
    % Calculate marginal entropy H(y)
    
%     pY = [0, 0];    % [y = +1, y = -1]
%     for i=1:length(Y)
%         if Y(i) >= 0
%             pY(1) = pY(1) + D(i);
%         else
%             pY(2) = pY(2) + D(i);
%         end
%     end


%%% START
    pYp = D'*(Y == 1);
    hY = -(entropy(pYp) + entropy(1 - pYp));
    
    for i=1:k
        Xfeat = X(:,i);
        Xsorted = unique(sort(Xfeat));

        for j=1:(length(Xsorted) - 1)
            % Calculate midpoint
            fs(j + ns) = i;
            midpoint = (Xsorted(j) + Xsorted(j+1)) / 2;
            xs(j + ns) = midpoint;
            
            %Calculate p(Xi)
            pXlt = D'*(Xfeat <= midpoint);
            pXgt = 1 - pXlt;
            
            pYpXlt = D'*(Y == 1 & Xfeat <= midpoint) / pXlt;
            pYpXgt = D'*(Y == 1 & Xfeat > midpoint) / pXgt;
            pYnXlt = D'*(Y == -1 & Xfeat <= midpoint) / pXlt;
            pYnXgt = D'*(Y == -1 & Xfeat > midpoint) / pXgt;
            % Calculate matrix of conditional entropies H(Y | Xi)
            hYX = -(pXlt*(entropy(pYpXlt) + entropy(pYnXlt)) + pXgt*(entropy(pYpXgt) + entropy(pYnXgt)));
            
            % Gain = difference in entropies H(y) - H(y | Xi)
            gains(j + ns) = hY - hYX;
        end
        ns = ns + length(Xsorted) - 1;
    end
    
    % Only return the ns splits (remove zero padding we pre-allocated)
    fs = fs(1:ns);
    xs = xs(1:ns);
    gains = gains(1:ns);
end

