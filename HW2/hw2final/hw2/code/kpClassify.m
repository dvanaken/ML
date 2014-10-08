function [ c ] = kpClassify( XTrain, XTest, w, d )
    % Filler code, replace with your own.
    nTest = size(XTest,1);
    c = zeros(nTest,1);
    k = zeros(nTest, nTest);
    for i=1:nTest
        for j=1:nTest
            k(i,j) = (XTrain(i,:) * XTest(j,:)')^d;
        end
    end
    
    for i=1:nTest
        ki = k(:,i);
        c(i,:) = sign(ki' * w);
    end
end

