function [ Dnew ] = computeNewWeights( X, Y, D, alpha, s)

    function res = h(X,s)
       x = X(s.f);
       if x <= s.x
           res = s.o;
       else
           res = s.o*-1;
       end
    end

%COMPUTENEWWEIGHTS 
    Dnew = zeros(size(D));
    for i=1:size(D)
        mid = -alpha*Y(i)*h(X(i,:),s);
        Dnew(i) = D(i)*exp(mid);
    end
    Dnew = Dnew / norm(Dnew,1);
end

