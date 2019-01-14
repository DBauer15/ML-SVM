function [alpha,w0] = trainSVM(X,t)

nLabels = size(t, 1);
nAttributes = size(X, 2);

%H = diag([ones(1,nAttributes) 0]);
H = (t*t').*(X*X');
%f = zeros(nAttributes+1, 1);
f = -ones(1, nLabels);

%A = -diag(t)*[X ones(nLabels, 1)];
A = zeros(1, nLabels);
%c = -ones(nLabels, 1);
c = 0;

Aeq = t';
ceq = 0;
LB = zeros(nLabels, 1);
UB = 1000 * ones(nLabels, 1);


%x = quadprog(H, f, A, c);
alpha = quadprog(H, f, A, c, Aeq, ceq, LB, UB);
i = min(find((alpha>0.1)&(t==1)));
G = X*X';
w0 = 1 - G(i,:)*(alpha.*t);
end

