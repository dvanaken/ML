function [ cls ] = LRclassify( XTrain, yTrain, XTest )
    f = size(XTrain,2);
    m = size(XTest,1);
    
    % Train the model
    fgrad = @(w) LRgradient( XTrain, yTrain, w );
    flogl = @(w) LRlogLikelihood( XTrain, yTrain, w );
    w0 = zeros(f,1);
    step = 0.1;
    niter = 500;
    [w] = gradDescent(flogl, fgrad, w0, step, niter); %optimized w
    
    % Use the model to classify 
    % (!!) Filler code, replace with your own.
    probs = zeros(m,2);
    for j=1:m,
        probs(j,:) = LRprob(XTest(j,:),w);
    end
    cls = probs(:,1) < probs(:,2);
end