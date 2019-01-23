function [XX_train,tt_train,X_test,t_test] = createMNISTPartitions(numpartitions,partitionsize,class1,class2)

[X_train,t_train,X_test,t_test] = createMNISTData(Inf, Inf, class1, class2);

imagesize = 28;
XX_train = zeros(partitionsize, imagesize^2, numpartitions);
tt_train = zeros(partitionsize, 1, numpartitions);

for n = 1:numpartitions
    XX_train(:,:,n) = X_train(1+((n-1)*partitionsize):(n*partitionsize),:);
    tt_train(:,:,n) = t_train(1+((n-1)*partitionsize):(n*partitionsize),:);
end

end

