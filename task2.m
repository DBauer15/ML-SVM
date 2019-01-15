close all
clear
clc

%% Create Data
[X_train, t_train] = createData(500);
[X_test, t_test] = createData(100);

%% Train SVM
[alpha, w0] = trainSVM(X_train, t_train, @rbfkernel);
w = X_train' * (alpha.*t_train);

%% Evaluate SVM
y = discriminant(alpha, w0, X_train, t_train, X_test, @rbfkernel);
ncorrect = sum(sign(y) == t_test);
ntotal = size(t_test,1);
eval = ncorrect/ntotal*100;
fprintf('Correctly classified: %d/%d (%d %%)\n', ncorrect, ntotal, eval);

%% Plot Data 2D
plotData2D(X_train, t_train);
hold on 
plotHyperplane2D(X_train, t_train, alpha, w0, @rbfkernel);
hold off

%% Plot Data 3D
plotData3D(X_train, t_train);
hold on
plotHyperplane3D(X_train, t_train, alpha, w0, @rbfkernel);
hold off
