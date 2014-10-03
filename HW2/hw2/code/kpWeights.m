function [ w ] = kpWeights( XTrain, yTrain, nIter, d )
    % Filler code, replace with your own.
    nTrain = size(XTrain,1);
    w = zeros(nTrain,1);
    k = zeros(nTrain, nTrain);
    for i=1:nTrain
        for j=1:nTrain
            k(i,j) = (XTrain(i,:) * XTrain(j,:)')^d;
        end
    end
    
    for n=1:nIter
        for i=1:nTrain
            yi = yTrain(i,:);
            ki = k(i,:);
            res = sign(ki * w);
            if res ~= yi
                w(i,:) = w(i,:) + yi; 
            end
        end
    end
end

