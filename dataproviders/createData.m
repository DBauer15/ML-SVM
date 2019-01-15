function [X,t] = createData(N)

minoff = 4;
offset = 10;

X1 = [randn(N/2,1); randn(N/2,1)+max(minoff,offset*rand())];
X2 = [randn(N/2,1); randn(N/2,1)+max(minoff,offset*rand())];
X = [X1 X2];
t = [ones(N/2,1); -ones(N/2,1)];
end

