function [] = plotData3D(X,t)
X1 = X(:,1);
X2 = X(:,2);
Z = zeros(size(X1,1),1);

scatter3(X1(t==1), X2(t==1), Z(t==1), 10, 'r', 'filled');
hold on
scatter3(X1(t==-1), X2(t==-1), Z(t==-1), 10, 'b', 'filled');
hold off

end

