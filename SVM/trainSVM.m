function [alpha,w0] = trainSVM(X,t,kernel)

nLabels = size(t, 1);
G = kernel(X,X);

%H = (t*t').*(X*X');
H = (t*t').*G;

f = -ones(1, nLabels);

A = zeros(1, nLabels);
b = 0;

Aeq = t';
beq = 0;
LB = zeros(nLabels, 1);

C = Inf;
UB = C * ones(nLabels, 1);


alpha = quadprog(H, f, A, b, Aeq, beq, LB, UB);
i = min(find((alpha>0.01)&(t==1)));


w0 = 1 - G(i,:)*(alpha.*t);
end

