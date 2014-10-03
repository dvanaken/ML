function [ c ] = pClassify( XTest, w)
    % Filler code, replace with your own.
    nTest = size(XTest,1);
    m = XTest * w;
    c = zeros(nTest,1);
    for i=1:nTest,
        if m(i,:) > 0
            c(i,:) = 1;
        else
            c(i,:) = -1;
        end
    end
end

