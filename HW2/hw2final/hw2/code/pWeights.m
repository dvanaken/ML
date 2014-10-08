function [ w ] = pWeights( XTrain, yTrain, nIter)
    % Filler code, replace with your own.
    nFeat = size(XTrain,2);
    w = zeros(nFeat,1);
    nSamps = size(XTrain,1);
    for j=1:nIter
        for i=1:nSamps
            xi = XTrain(i,:);
            yi = yTrain(i,:);
            si = sign(xi * w);
            if (si ~= yi)
                w = w + xi'*yi;
            end
        end
    end
end

