function [ testerr ] = kNNTest( k,dFeatures,trainX,trainy,tX,ty )
%KNNTEST Summary of this function goes here
%   Detailed explanation goes here
iterations = size(dFeatures,2);
testerr = ones(1,iterations);
for i=1:iterations
   curmd = kNN(trainX(:,dFeatures(1:i,i)'),trainy,k);
   eY =  kNNpredict(curmd,tX(:,dFeatures(1:i,i)'));
   erate_i = sum(eY ~= ty) / size(ty,1);
   testerr(i)=erate_i;
end

end

