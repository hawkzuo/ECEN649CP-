function [ md ] = SVMfit( X,y,Kernelmark )
%SVMFIT Summary of this function goes here
%   Detailed explanation goes here
if(Kernelmark == 1)
    md = fitcsvm(X,y,'KernelFunction','rbf','BoxConstraint',10);
else
    md = fitcsvm(X,y,'BoxConstraint',10);
end

end

