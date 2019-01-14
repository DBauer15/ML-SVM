function [] = plotHyperplane3D(X,t,alpha,w0)

w = X' * (alpha.*t);

x1min = min(X(:,1));
x1max = max(X(:,1));
x2min = min(X(:,2));
x2max = max(X(:,2));
step = 0.05;

% Calculate plane intersect and margin intersect
hyper1 = min(X)-1:max(X)+1;
hyper2 = (-w(1)*hyper1 - w0)/w(2);
hyper3 = zeros(size(hyper1));
margin1 = hyper2 + (1/w(2));
margin2 = hyper2 - (1/w(2));

% Extract support vectors
support = X(alpha>0.01,:);
support1 = support(:,1);
support2 = support(:,2);
support3 = zeros(size(support1));

% Calculate mesh grid for 3D plane
[x1,x2] = meshgrid(x1min:step:x1max, x2min:step:x2max);
z = w(1)*x1 + w(2)*x2 + w0;



surf(x1,x2,z,'LineStyle','none','FaceAlpha',0.5);
hold on
plot3(hyper1, hyper2, hyper3, 'k');
hold on
plot3(hyper1, margin1, hyper3, 'k--');
hold on
plot3(hyper1, margin2, hyper3, 'k--');
hold on
scatter3(support1, support2, support3, 40, 'g');
hold off

end

