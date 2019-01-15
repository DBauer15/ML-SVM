function [X_train,t_train,X_test,t_test] = createMNISTData(N_train, N_test, class1, class2)

% Load data
X_train = loadMNISTImages('train-images-idx3-ubyte');
t_train = loadMNISTLabels('train-labels-idx1-ubyte');
X_test = loadMNISTImages('t10k-images-idx3-ubyte');
t_test = loadMNISTLabels('t10k-labels-idx1-ubyte');

% Filter to desired class
X_train = X_train(:,t_train == class1 | t_train == class2);
t_train = t_train(t_train == class1 | t_train == class2);
X_test = X_test(:,t_test == class1 | t_test == class2);
t_test = t_test(t_test == class1 | t_test == class2);

% Filter to desired size and transpose images for format
X_train = X_train(:,1:N_train)';
t_train = t_train(1:N_train);
t_train(t_train==class1) = 1;
t_train(t_train==class2) = -1;
X_test = X_test(:,1:N_test)';
t_test = t_test(1:N_test);
t_test(t_test == class1) = 1;
t_test(t_test == class2) =-1;

end

