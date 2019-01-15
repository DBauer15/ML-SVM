function [alpha,w0] = trainSVM(X,t,kernel)

nLabels = size(t, 1);
G = kernel(X,X);

H = (t*t').*G;

f = -ones(1, nLabels);

A = zeros(1, nLabels);
b = 0;

Aeq = t';
beq = 0;
LB = zeros(nLabels, 1);

C = 10;
UB = C * ones(nLabels, 1);


alpha = quadprog(H, f, A, b, Aeq, beq, LB, UB);
%i = min(find((alpha>0.01)&(t==1)));
i = find((alpha>0.0001)&(alpha<C-0.0001));

w0 = 1./t(i) - G(i,:)*(alpha.*t);
w0 = mean(w0);
end

