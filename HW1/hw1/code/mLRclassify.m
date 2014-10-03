function [ cls ] = mLRclassify( XTrain, yTrain, XTest )
    f = size(XTrain,2);
    numClass = max(yTrain);
    m = size(XTest,1);
    
    % Train the model
    fgrad = @(W) mLRgradient( XTrain, yTrain, W ); % Switched to mLR
    flogl = @(W) mLRlogLikelihood( XTrain, yTrain, W ); % Switched to mLR
    W0 = zeros(numClass, f); % W is now a matrix
    step = 0.05;
    niter = 1000;
    W = gradDescent(flogl, fgrad, W0, step, niter);
    
    
    % Use the model to classify 
    % (!!) Filler code, replace with your own.
    cls = zeros(m,1);
    probs = zeros(m,numClass);
    for i=1:m,
         probs(i,:) = mLRprob(XTest(i,:),W);
         [C,I] = max(probs(i,:));
         cls(i,:) = I(1,:);
    end
end