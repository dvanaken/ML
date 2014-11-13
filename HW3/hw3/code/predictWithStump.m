function [ Ypred ] = predictWithStump( X, s )
%PREDICTWITHSTUMP 
    Ypred = ones(size(X,1),1);
    xi = X(:,s.f);
    sleft = s.o;
    sright = sleft * -1;
    for i=1:length(Ypred)
         if xi(i) <= s.x
             Ypred(i) = Ypred(i)*sleft;
         else
             Ypred(i) = Ypred(i)*sright;
         end
    end
end

