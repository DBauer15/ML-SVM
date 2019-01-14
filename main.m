close all
clear
clc

%% TODO %%
% w0 is substracted in formula -> correct!?

%% Create Data
[X_train, t_train] = createData(500);


%% Train SVM
[alpha, w0] = trainSVM(X_train, t_train);
w = X_train' * (alpha.*t_train);

%% Plot Data 2D
plotData2D(X_train, t_train);
hold on
plotHyperplane2D(X_train, t_train, alpha, w0);
hold off

%% Plot Data 3D
plotData3D(X_train, t_train);
hold on
plotHyperplane3D(X_train, t_train, alpha, w0);
hold off