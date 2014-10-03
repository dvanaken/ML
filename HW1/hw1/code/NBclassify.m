function [ classPred ] = NBclassify( XTrain, XTest, yTrain )
    % Filler code, replace with your own.
    numTest = size(XTest,1);
    classPred = zeros(numTest, 1);
    numFeat = size(XTrain, 2);
    %covariance = cov(XTrain);
    [mu, sigma] = NBparameters(XTrain, yTrain);
    numClass = size(mu, 1);
    %norm = 1/sqrt(pi^numFeat * det(covariance));
    priors = NBprior(yTrain)';
    for i=1:numTest,
        testRow = XTest(i,:);
        probs = zeros(1,numClass);
        for k = 1:numClass,
            covariance = diag(sigma(k,:));
            norm = 1/sqrt(pi^numFeat * det(covariance));
            diffs = testRow - mu(k,:);
            exponent = -0.5 * (diffs * inv(covariance) * transpose(diffs));
            probs(k) = exp(exponent) * norm * priors(k);
        end
        [C,I] = max(probs);
        classPred(i) = I;
    end
end



