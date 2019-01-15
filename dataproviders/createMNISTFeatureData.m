function [X_train,t_train,X_test,t_test] = createMNISTFeatureData(N_train, N_test, class1, class2)

% Set images size (always 28x28 for MNIST)
imagesize = 28;

% Load raw data first
[rX_train, t_train, rX_test, t_test] = createMNISTData(N_train, N_test, class1, class2);

% Compute features
featuretype = {'FilledArea', 'Solidity'};
X_train = zeros(N_train, 2);
X_test = zeros(N_test, 2);

for n = 1 : N_train
    image = reshape(rX_train(n, :), [imagesize, imagesize]);
    imagebw = image > 0.5;
    stats = regionprops(imagebw, featuretype);
    X_train(n, 1) = stats.(featuretype{1});
    X_train(n, 2) = stats.(featuretype{2});
end
for n = 1 : N_test
    image = reshape(rX_test(n, :), [imagesize, imagesize]);
    imagebw = image > 0.5;
    stats = regionprops(imagebw, featuretype);
    X_test(n, 1) = stats.(featuretype{1});
    X_test(n, 2) = stats.(featuretype{2});
end

% Normalize results
X_train(:, 1) = X_train(:, 1) / max(X_train(:, 1));
X_train(:, 2) = X_train(:, 2) / max(X_train(:, 2));
X_test(:, 1) = X_test(:, 1) / max(X_test(:, 1));
X_test(:, 2) = X_test(:, 2) / max(X_test(:, 2));


end

