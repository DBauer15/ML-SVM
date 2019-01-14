function [] = plotHyperplane2D(X,t,alpha,w0)

% Calculate plane intersect
w = X' * (alpha.*t);
hyper1 = min(X)-1:max(X)+1;
hyper2 = (-w(1)*hyper1 - w0)/w(2);

% Calculate margin offset and intersect
margin1 = hyper2 + (1/w(2));
margin2 = hyper2 - (1/w(2));

% Extract support vectors
support = X(alpha>0.01,:);
support1 = support(:,1);
support2 = support(:,2);

% Plot everything
plot(hyper1,hyper2);
hold on
plot(hyper1,margin1,'k--');
hold on
plot(hyper1,margin2,'k--');
hold on
scatter(support1, support2, 40, 'g');

end

