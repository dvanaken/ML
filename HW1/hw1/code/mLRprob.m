function [ p ] = mLRprob( x, W )
    % Filler code, replace with your own.
    c = size(W,1);
    p = ones(c,1);
    
    const = 0;
    for j = 1:c,
        classWeight = W(j,:)';
        p(j,:) = exp(x*classWeight);
        const = const + p(j,:);
    end
    p = p / const;
end