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
%     Y = [ -1,   1,   1,  -1,  -1,   1,  -1];
%     D = [0.1, 0.2, 0.1, 0.1, 0.3, 0.1, 0.1];

    function logm = entropy(x)
        if x == 0
            logm = 0; 
        else
            logm = x*log2(x);
        end
    end
    
    X = [2.6, 0.1, 3.5, 1.1, 1.1 ; 2.1, 3.4, 0.5, 0.1, 2.2]';
    Y = [ -1,  -1,   1,  -1,  -1]';
    D = [0.3, 0.1, 0.2, 0.3, 0.1]';

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
    
%     for i=1:k
%         Xfeat = X(:,i);
%         Xsorted = unique(sort(Xfeat));
% 
%         for j=1:(length(Xsorted) - 1)
%             fs(j + ns) = i;
%             midpoint = Xsorted(j) + (Xsorted(j+1) - Xsorted(j)) * 0.5;
%             xs(j + ns) = midpoint;
%             Ycountl = [D'*(Y == 1 & Xfeat <= midpoint), D'*(Y == -1 & Xfeat <= midpoint)];
%             Ycountr = [D'*(Y == 1 & Xfeat > midpoint), D'*(Y == -1 & Xfeat > midpoint)];
%             nleft = D'*(Xfeat <= midpoint);
%             nright = D'*(Xfeat > midpoint);
%             
%             H_left = 0;
%             H_right = 0;
%             
%             for c=1:2
%                 if Ycountl(c) > 0
%                     H_left =  H_left - ((Ycountl(c) / nleft) * log2 (Ycountl(c) / nleft));
%                 end
%                 if Ycountr(c) > 0
%                     H_right =  H_right - ((Ycountr(c) / nright) * log2 (Ycountr(c) / nright));
%                 end
%             end
%             e1 = nleft*H_left;
%             e2 = nright*H_right;
%             gains(j + ns) = hY - (e1+e2);
%         end
%         ns = ns + length(Xsorted) - 1;
%     end
    
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
            
            hYX = -(pXlt*(entropy(pYpXlt) + entropy(pYnXlt)) + pXgt*(entropy(pYpXgt) + entropy(pYnXgt)));
            gains(j + ns) = hY - hYX;
        end
        ns = ns + length(Xsorted) - 1;
    end

    % Calculate matrix of conditional entropies H(Y | Xi)
    % Gain = difference in entropies H(y) - H(y | Xi)
    
%     for i=1:k
%         Xfeat = X(:,i); % Look at all samples of a single feature
%         Xsorted = unique(sort(Xfeat));
%         nsf = length(Xsorted) - 1;  % There are #distinctX - 1 midpoints
%         ns_old = ns;
%         ns = ns + nsf;  % Add this to total number of stumps
%         for j=1:nsf
%             fs(ns_old + j,1) = i;  % Update the feature (this is equal to i in the outer loop)
%             xs(ns_old + j,1) = (Xsorted(j) + Xsorted(j+1)) / 2; % calculate the midpoint between consecutive distinct Xs
%             split = xs(ns_old + j,1);
%             pX = [0, 0];    % [x <= split, x > split]
%             pXY = zeros(2,2);   % [Y = 1 & x <= split, Y = 1 & x > split ; Y = -1 & x <= split, Y = -1 & x > split]
%             for m=1:n
%                 weight = D(m);
%                 if Xfeat(m) <= split
%                     pX(1) = pX(1) + weight;
%                     if Y(m) > 0
%                         pXY(1,1) = pXY(1,1) + weight;
%                     else 
%                         pXY(2,1) = pXY(2,1) + weight;
%                     end
%                 else
%                     pX(2) = pX(2) + weight;
%                     if Y(m) > 0
%                         pXY(1,2) = pXY(1,2) + weight;
%                     else
%                         pXY(2,2) = pXY(2,2) + weight;
%                     end
%                 end
%             end
%             pXY(:,1) = pXY(:,1) / pX(1);
%             pXY(:,2) = pXY(:,2) / pX(2);
%             
%             hYX1 = -pX(1)*(entropy(pXY(1,1)) + entropy(pXY(2,1)));
%             hYX2 = -pX(2)*(entropy(pXY(1,2)) + entropy(pXY(2,2)));
%             hYX = hYX1 + hYX2;
%             gains(ns_old + j,1) = hY - hYX;
%         end
%     end
    
    % Only return the ns splits (remove zero padding we pre-allocated)
    fs = fs(1:ns);
    xs = xs(1:ns);
    gains = gains(1:ns);
end

