function [y] = discriminant(alpha,w0,X,t,Xnew,kernel)

nLabels = size(Xnew(:,1), 1);

%G=Xnew*X';
G = kernel(Xnew,X);
y = G*(alpha.*t)+w0*ones(nLabels,1);


end

