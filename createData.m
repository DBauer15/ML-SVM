function [X,t] = createData(N)
X1 = [randn(N/2,1); randn(N/2,1)+max(5,10*rand())];
X2 = [randn(N/2,1); randn(N/2,1)+max(5,10*rand())];
X = [X1 X2];
t = [ones(N/2,1); -ones(N/2,1)];
end

