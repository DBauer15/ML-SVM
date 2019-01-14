function [] = plotHyperplane2D(X,t,alpha,w0)

w = X' * (alpha.*t);
hyper1 = min(X)-1:max(X)+1;
hyper2 = (-w(1)*hyper1 - w0)/w(2);

plot(hyper1,hyper2);

end

