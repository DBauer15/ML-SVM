function [] = plotHyperplane3D(X,t,alpha,w0)

w = X' * (alpha.*t);

x1min = min(X(:,1));
x1max = max(X(:,1));
x2min = min(X(:,2));
x2max = max(X(:,2));
step = 0.05;

[x1,x2] = meshgrid(x1min:step:x1max, x2min:step:x2max);

z = w(1)*x1 + w(2)*x2 + w0;

surf(x1,x2,z,'LineStyle','none','FaceAlpha',0.5);

end

