function Problem1PartB
    X = linspace(-10, 10, 1001);
    Xstar = [0.5, 1, 2, 2.5, 3];
    Ystar = [-1, 1, 3, 1.5, 0];
    rng(8);
    function cov = getLinCov(x1, x2)
        cov = x1 * x2;
    end

    function cov = getSqExpCov(x1, x2, lambda)
        cov = zeros(length(x1), length(x2));
        for i=1:length(x1)
            for j=1:length(x2)
                 cov(i,j) = exp(-1/(2*lambda^2)*(x1(i)-x2(j))^2);
            end
        end
    end

    function cov = getPerCov(x1, x2, lambda)
        cov = zeros(length(x1), length(x2));
        for a=1:length(x1)
            for j=1:length(x2)
                 cov(a,j) = exp(-2/lambda^2*sin(0.5*abs(x1(a)-x2(j)))^2);
            end
        end
    end

    function [mu, cov] = getParams(kXX, kXsX, kXsXs, sigma, Ystar)
        ide = kXsX' / (kXsXs + sigma^2*eye(size(kXsXs, 1), size(kXsXs, 2)));
        mu = ide * Ystar';
        cov = kXX - ide * kXsX;
        cov = (cov + cov')/2;
    end
    lenX = length(X);
    numGens = 3;
    sigma = 2;
    lambda = 1;
    
    % Linear vars
    %k1 = [getLinCov(X', X), getLinCov(Xstar', X), getLinCov(Xstar', Xstar)];
    [mu1, cov1] = getParams(getLinCov(X', X), getLinCov(Xstar', X), getLinCov(Xstar', Xstar), sigma, Ystar);
    sdev1 = sqrt(diag(cov1)');
    fxy1 = zeros(numGens, lenX);
    
    % Square exp. vars
    [mu2, cov2] = getParams(getSqExpCov(X', X, lambda), getSqExpCov(Xstar', X, lambda), getSqExpCov(Xstar', Xstar, lambda), sigma, Ystar);
    sdev2 = sqrt(diag(cov2)');
    fxy2 = zeros(numGens, lenX);
    
    % Periodic vars
    [mu3, cov3] = getParams(getPerCov(X', X, lambda), getPerCov(Xstar', X, lambda), getPerCov(Xstar', Xstar, lambda), sigma, Ystar);
    sdev3 = sqrt(diag(cov3)');
    fxy3 = zeros(numGens, lenX);
    
    for g=1:numGens
        fxy1(g,:) = mvnrnd(mu1, cov1);
        fxy2(g,:) = mvnrnd(mu2, cov2);
        fxy3(g,:) = mvnrnd(mu3, cov3);
    end
    
    %% P1(a) Plot covariance curves
    Xx = [X, fliplr(X)];

    figure
    %subplot(3, 1, 1);
    plot(X, fxy1);
    hold on;
    plot(X, mu1, '-.c');
    scatter(Xstar, Ystar);
    pwv = [sdev1(1,:), -sdev1(1,:)];
    fill(Xx, pwv, 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    hold off;
    title('Linear Covariance Function');
    xlabel('X');
    ylabel('f(X)|Y*');
    legend('s1', 's2', 's3', 'mean');
    
    figure
    %subplot(3, 1, 2);
    plot(X, fxy2);
    hold on;
    plot(X, mu2, '-.c');
    scatter(Xstar, Ystar);
    pwv = [sdev2(1,:), -sdev2(1,:)];
    fill(Xx, pwv, 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    hold off;
    title('Squared Exponential Covariance Function');
    xlabel('X');
    ylabel('f(X)|Y*');
    legend('s1', 's2', 's3', 'mean');
    
    figure
    %subplot(3, 1, 3);
    plot(X, fxy3);
    hold on;
    plot(X, mu3, '-.c');
    scatter(Xstar, Ystar);
    pwv = [sdev3(1,:), -sdev3(1,:)];
    fill(Xx, pwv, 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    hold off;
    title('Periodic Covariance Function');
    xlabel('X');
    ylabel('f(X)|Y*');
    legend('s1', 's2', 's3', 'mean');
    
    %% 1.(e)
    mus = zeros(numGens, lenX);
    fxs = zeros(numGens, lenX);
    lambdas = [0.5, 1, 4];
    
    [mus(1,:), cov11] = getParams(getSqExpCov(X', X, lambdas(1)), getSqExpCov(Xstar', X, lambdas(1)), getSqExpCov(Xstar', Xstar, lambdas(1)), sigma, Ystar);
    fxs(1,:) = mvnrnd(mus(1,:), cov11);
    
    [mus(2,:), cov22] = getParams(getSqExpCov(X', X, lambdas(2)), getSqExpCov(Xstar', X, lambdas(2)), getSqExpCov(Xstar', Xstar, lambdas(2)), sigma, Ystar);
    fxs(2,:) = mvnrnd(mus(2,:), cov22);
        
        
    [mus(3,:), cov33] = getParams(getSqExpCov(X', X, lambdas(3)), getSqExpCov(Xstar', X, lambdas(3)), getSqExpCov(Xstar', Xstar, lambdas(3)), sigma, Ystar);
    fxs(3,:) = mvnrnd(mus(3,:), cov33);
    
    figure
    %subplot(3, 1, 1);
    plot(X, fxs(1,:));
    hold on;
    plot(X, mus(1,:), '-.c');
    scatter(Xstar, Ystar);
    sdev = sqrt(diag(cov11)');
    pwv = [sdev(1,:), -sdev(1,:)];
    fill(Xx, pwv, 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    hold off;
    title('Squared Exponential Covariance Function: Lambda^2 = 0.25');
    xlabel('X');
    ylabel('f(X)|Y*');
    legend('sample', 'mean');
    
    
    figure
    %subplot(3, 1, 2);
    plot(X, fxs(2,:));
    hold on;
    plot(X, mus(2,:), '-.c');
    scatter(Xstar, Ystar);
    sdev = sqrt(diag(cov22)');
    pwv = [sdev(1,:), -sdev(1,:)];
    fill(Xx, pwv, 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    hold off;
    title('Squared Exponential Covariance Function: Lambda^2 = 1');
    xlabel('X');
    ylabel('f(X)|Y*');
    legend('sample', 'mean');
    
    figure
    %subplot(3, 1, 3);
    plot(X, fxs(3,:));
    hold on;
    plot(X, mus(3,:), '-.c');
    scatter(Xstar, Ystar);
    sdev = sqrt(diag(cov33)');
    pwv = [sdev(1,:), -sdev(1,:)];
    fill(Xx, pwv, 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    hold off;
    title('Squared Exponential Covariance Function: Lambda^2 = 16');
    xlabel('X');
    ylabel('f(X)|Y*');
    legend('sample', 'mean');
end


