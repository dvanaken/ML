function Problem1PartA
    X = linspace(-10, 10, 1001);
    lenX = length(X);
    mean = zeros(1, lenX);
    rng(8);

    %% Parameters to define
    lambda = .75;

    %% First covariance function: linear
    function cov = getLinCov(X)
        cov = X' * X;
    end

    %% Second covariance function: squared exponential
    function cov = getSqExpCov(X, lambda)
        cov = zeros(lenX, lenX);
        for i2=1:lenX
            for j2=1:lenX
                 cov(i2,j2) = exp(-1/(2*lambda^2)*(X(i2)-X(j2))^2);
            end
        end
    end

    %% Third covariance function: periodic
    function cov = getPerCov(X,lambda)
        cov = zeros(lenX, lenX);
        for i3=1:lenX
            for j=1:lenX
                 cov(i3,j) = exp(-2/(lambda^2)*sin(0.5*abs(X(i3)-X(j)))^2);
            end
        end
    end
    
    %% Compute covariances
    cov1 = getLinCov(X);
    cov2 = getSqExpCov(X,lambda);
    cov3 = getPerCov(X,lambda);
    %% Compute point-wise variances
    numGens = 3;
    pwVars = zeros(numGens, lenX);
    pwVars(1,:) = sqrt(diag(cov1)');
    pwVars(2,:) = sqrt(diag(cov2)');
    pwVars(3,:) = sqrt(diag(cov3)');

    %% Generate samples for each covariance function
    fX1s = zeros(numGens, lenX);
    fX2s = zeros(numGens, lenX);
    fX3s = zeros(numGens, lenX);

    for i=1:numGens
        fX1s(i,:) = mvnrnd(mean, cov1);
        fX2s(i,:) = mvnrnd(mean, cov2);
        fX3s(i,:) = mvnrnd(mean, cov3);
    end

    %% P1(a) Plot covariance curves
    Xx = [X, fliplr(X)];

    figure
    %subplot(3, 1, 1);
    plot(X, fX1s);
    hold on;
    plot(X, mean, '-.c');
    Yy = [pwVars(1,:), -pwVars(1,:)];
    fill(Xx, Yy, 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    hold off;
    title('Linear Covariance Function');
    xlabel('X');
    ylabel('f(X)');
    legend('s1', 's2', 's3', 'mean');

    figure
    %subplot(3, 1, 2);
    plot(X, fX2s);
    hold on;
    plot(X, mean, '-.c');
    Yy = [pwVars(2,:), -pwVars(2,:)];
    fill(Xx, Yy, 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    hold off;
    title('Squared Exponential Covariance Function');
    xlabel('X');
    ylabel('f(X)');
    legend('s1', 's2', 's3', 'mean');

    figure
    %subplot(3, 1, 3);
    Yy = [pwVars(3,:), -pwVars(3,:)];
    plot(X, fX3s);
    hold on;
    plot(X, mean, '-.c');
    fill(Xx, Yy, 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    hold off;
    title('Periodic Covariance Function');
    xlabel('X');
    ylabel('f(X)');
    legend('s1', 's2', 's3', 'mean');

    %% Select 3 different sigmas and sample with 1 covariance function
    sigmas = [1, .1, .001];
    Ys = zeros(numGens, lenX);
    
    covv = getPerCov(X, 3);
    fxx = mvnrnd(mean, covv);
    for i=1:numGens
        s = repmat(sigmas(i), 1, lenX);
        Ys(i,:) = mvnrnd(fxx, diag(s));
    end



    %% P1(b) Plot Y with different noise params
    figure
    plot(X, Ys);
    title('Periodic: Sample different noise parameters');
    legend('sigma^2=1.0', 'sigma^2=0.1', 'sigma^2=0.001');
    xlabel('X');
    ylabel('Y');
end
















