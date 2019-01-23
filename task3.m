close all
clear
clc

%% SETUP
C = Inf;
kernel = @linearkernel;
partitions = 150;
partitionsize = 70;

%% Create Data (MNIST raw)
[XX_train, tt_train, X_test, t_test] = createMNISTPartitions(partitions, partitionsize, 1, 0);

%% Train SVM and calculate Rk (for linear kernel)
Rk = zeros(partitions,1);
for n = 1:partitions
    % Assign current training set
    X_train = XX_train(:,:,n);
    t_train = tt_train(:,:,n);
    
    % Train SVM
    [alpha, w0] = trainSVM(X_train, t_train, C, kernel);
    w = X_train' * (alpha.*t_train);
    
    % Evaluate
    y = discriminant(alpha, w0, X_train, t_train, X_test, kernel);
    ncorrect = sum(sign(y) == t_test);
    ntotal = size(t_test,1);
    currentRk = 1 - (ncorrect/ntotal);
    Rk(n) = currentRk;
end

Ravg = mean(Rk);
disp(Rk);
disp(Ravg);


%% Train SVM and calculate Rk (for rbf kernel)
Rk = zeros(partitions,1);
Tk = zeros(partitions,1);
Supk = zeros(partitions,1);
for n = 1:partitions
    % Assign current training set
    X_train = XX_train(:,:,n);
    t_train = tt_train(:,:,n);
    
    % Train SVM
    [alpha, w0] = trainSVM(X_train, t_train, C, kernel);
    w = X_train' * (alpha.*t_train);
    
    % Evaluate test data
    y = discriminant(alpha, w0, X_train, t_train, X_test, kernel);
    ncorrect = sum(sign(y) == t_test);
    ntotal = size(t_test,1);
    errorrate = 1 - (ncorrect/ntotal);
    Rk(n) = errorrate;
    nsupportvectors = numel(alpha(alpha>0.0001 & alpha<C-0.0001));
    Supk(n) = nsupportvectors;
    
    % Evaluate training data
    y = discriminant(alpha, w0, X_train, t_train, X_train, kernel);
    ncorrect = sum(sign(y) == t_train);
    ntotal = size(t_train,1);
    errorrate = 1 - (ncorrect/ntotal);
    Tk(n) = errorrate;
end

Ravg = mean(Rk);
Tavg = mean(Tk);
Supavg = mean(Supk);

fprintf('C: %d\n', C);
fprintf('Ravg: %f (%f %%)\n', Ravg, Ravg*100);
fprintf('Tavg: %f (%f %%)\n', Tavg, Tavg*100);
fprintf('Supavg: %f\n', Supavg);


%% Cross Validation
Rk = zeros(partitions,1);
Supk = zeros(partitions,1);
for n = 1:partitions
    % Assign current training set
    X_train = XX_train(:,:,n);
    t_train = tt_train(:,:,n);
    
    % Train SVM
    [alpha, w0] = trainSVM(X_train, t_train, C, kernel);
    w = X_train' * (alpha.*t_train);
    
    for j = 1:partitions
        if j == n
            continue
        end
        
        X_cross = XX_train(:,:,j);
        t_cross = tt_train(:,:,j);
        
        % Evaluate test data
        y = discriminant(alpha, w0, X_train, t_train, X_cross, kernel);
        ncorrect = sum(sign(y) == t_cross);
        ntotal = size(t_cross,1);
        errorrate = 1 - (ncorrect/ntotal);
        Rk(n) = errorrate;
        nsupportvectors = numel(alpha(alpha>0.0001 & alpha<C-0.0001));
        Supk(n) = nsupportvectors;
    end
end

Ravg = mean(Rk);
Supavg = mean(Supk);

fprintf('C: %d\n', C);
fprintf('Ravg: %f (%f %%)\n', Ravg, Ravg*100);
fprintf('Supavg: %f\n', Supavg);