X = linspace(-10, 10, 1001);
lenX = length(X);
mean = zeros(1, lenX);
rng(8);

%% Parameters to define
lamda = .75;

%% First covariance function: linear
cov1 = X' * X;
eig(cov1);
[~, P] = chol(cov1);
P;

%% Second covariance function: polynomial
cov2 = zeros(lenX, lenX);
for i=1:lenX
    for j=1:lenX
         cov2(i,j) = exp(-1/lamda*abs(X(i)-X(j)));
    end
end
eig(cov2);
[~, P] = chol(cov2);
P;

%% Third covariance function: periodic
cov3 = zeros(lenX, lenX);
for i=1:lenX
    for j=1:lenX
         cov3(i,j) = exp(-2/(lamda^2)*sin(0.5*abs(X(i)-X(j)))^2);
    end
end
eig(cov3);
[~, P] = chol(cov3);
P;

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

% figure
% subplot(3, 1, 1);
% plot(X, fX1s);
% hold on;
% plot(X, mean, '-.c');
% Yy = [pwVars(1,:), -pwVars(1,:)];
% fill(Xx, Yy, 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
% hold off;
% title('1.(a): Linear Covariance Function');
% xlabel('X');
% ylabel('f(X)');
% legend('s1', 's2', 's3', 'mean');
% 
% subplot(3, 1, 2);
% plot(X, fX2s);
% hold on;
% plot(X, mean, '-.c');
% Yy = [pwVars(2,:), -pwVars(2,:)];
% fill(Xx, Yy, 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
% hold off;
% title('1.(a): Exponential Covariance Function');
% xlabel('X');
% ylabel('f(X)');
% legend('s1', 's2', 's3', 'mean');
% 
% subplot(3, 1, 3);
% Yy = [pwVars(3,:), -pwVars(3,:)];
% fill(Xx, Yy, 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
% hold on;
% plot(X, fX3s);
% plot(X, mean, '-.c');
% hold off;
% title('1.(a): Periodic Covariance Function');
% xlabel('X');
% ylabel('f(X)');
% legend('s1', 's2', 's3', 'mean');

%% Select 3 different sigmas and sample with 1 covariance function
sigmas = [2, 1, 1/2];
Ys = zeros(numGens, lenX);

for i=1:numGens
    s = repmat(sigmas(i), 1, lenX);
    Ys(i,:) = mvnrnd(mvnrnd(mean, cov3), diag(s));
end



%% P1(b) Plot Y with different noise params
% figure
% plot(X, Ys);
% title('Periodic: Sample different noise parameters');
% legend('sigma=2', 'sigma=1', 'sigma=0.5');
% xlabel('X');
% ylabel('Y');

%% P1(e)

Xs = [0.5, 1, 2, 2.5, 3];
Ys = [-1, 1, 3, 1.5, 0];


%% First covariance function: linear
sigmas = [5, 0.5];
XX = X'*X;
XXs = X'*Xs;
XsX = Xs'*X;
XsXs = Xs'*Xs;
cfX1s = zeros(3,1001);
lenXs = length(Xs);
for i=1:2
    %rep = XXs/(XsXs + sigmas(i)^2*eye(lenXs, lenXs));
    %rep = XXs/XsXs;
    cMu = XXs*(inv(XsXs + sigmas(i)^2*eye(lenXs, lenXs))*Ys');
    cCov = XX - rep*XsX;
    cfX1s(i,:) = mvnrnd(cMu,cCov);
end


%% Second covariance function: polynomial
cov2 = zeros(lenX, lenX);
for i=1:lenX
    for j=1:lenX
         cov2(i,j) = exp(-1/lamda*abs(X(i)-X(j)));
    end
end
eig(cov2);
[~, P] = chol(cov2);
P;



%% Third covariance function: periodic
cov3 = zeros(lenX, lenX);
for i=1:lenX
    for j=1:lenX
         cov3(i,j) = exp(-2/(lamda^2)*sin(0.5*abs(X(i)-X(j)))^2);
    end
end
eig(cov3);
[~, P] = chol(cov3);
P;












