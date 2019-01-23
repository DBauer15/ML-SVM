function [] = plotHyperplane3D(X,t,alpha,w0,C,kernel)

%% Pre-computation of bounds, extraction of data

% Find bounds and pad them for more visual space
x1min = min(X(:,1));
x1max = max(X(:,1));
x2min = min(X(:,2));
x2max = max(X(:,2));
padding = max([abs(x1min) abs(x2min) abs(x1max) abs(x2max)]);
padding = padding*0.5;
x1min = x1min - padding;
x2min = x2min - padding;
x1max = x1max + padding;
x2max = x2max + padding;
step = 0.05;

% Extract support vectors
support = X(alpha>0.0001 & alpha<C-0.0001,:);
support1 = support(:,1);
support2 = support(:,2);
support3 = zeros(size(support1));


%% Preparation of mesh data for plane/intersect/margins

% Calculate mesh grid for 3D plane
[hyper1,hyper2] = meshgrid(x1min:step:x1max, x2min:step:x2max);
% Align grid coordinates in one long list (need for inference)
gridprobes = [hyper1(:) hyper2(:)];
G = kernel(gridprobes,X);
% Calculate Z values
hyper3 = G*(alpha.*t) + w0*ones(size(G,1),1);
% Reshape back to original matrix format
hyper3 = reshape(hyper3, [size(hyper1,1), size(hyper2,2)]);
% Calculate margins with +-1 offset
marginupper3 = hyper3 + 1;
marginlower3 = hyper3 - 1;


%% Plotting of data

% Plot support vectors
scatter3(support1, support2, support3, 40, 'g');
hold on
% Plot hyperplane
surf(hyper1,hyper2,hyper3,'LineStyle','none','FaceAlpha',0.5);
hold on
% Plot hyperplane intersect
contour(hyper1, hyper2, hyper3, [0 0], 'k', 'LineWidth', 1.2);
hold on
% Plot margins
contour(hyper1, hyper2, marginupper3, [0 0], 'k--');
hold on
contour(hyper1, hyper2, marginlower3, [0 0], 'k--');
hold off

end

