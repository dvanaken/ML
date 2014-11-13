function [s, eps] = chooseBestStump( X, Y, D, fs, xs, gains)
%CHOOSEBESTSTUMP Return the stump with the highest info gain. 
% Output: 
%   s - a struct with three fields: f, x, o. 
%       s.f - the feature along which you split
%       s.x - the value around which you split <= x, > x
%       s.o - the orientation of the stump = the label the stump assigns 
%               to the points <=x
%   eps - the weighted error of the stump s. 
%
% NOTE: The information gain only pins down f and x. The orientation 
% is given by whichever orientation leads to a lower stump error. 
% e.g. a stump separating -+ will have s.o = -1, and a stump separating 
% +- will have s.o = +1; In case of tie, take s.o = -1. 

    function res = h(X,s,o)
       x = X(s.f);
       if x <= s.x
           res = o;
       else
           res = o*-1;
       end
    end

    X = [2.6, 0.1, 3.5, 1.1, 1.1]';
    Y = [ -1,  -1,   1,  -1,  -1]';
    D = [0.3, 0.1, 0.2, 0.3, 0.1]';

    [ht,I] = max(gains);
    index = I(1);
    s.f = fs(index);
    s.x = xs(index);
    s.o = 0;
    
    o = [-1, 1];
    e = [0, 0];
    for i=1:2
        length(D)
        for j=1:size(D,1)
            %Y(j) ~= h(X(j,:),s,o(i))
            Y(j)
            e(i) = e(i) + D(j)*(Y(j) ~= h(X(j,:),s,o(i)));  
        end
        
    end
    if e(1) <= e(2)
        s.o = o(1);
    else
        s.o = o(2);
    end
end

