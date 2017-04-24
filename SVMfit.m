function [ md ] = SVMfit( X,y,Kernelmark )
%SVMFIT Summary of this function goes here
%   Detailed explanation goes here
if(Kernelmark == 1)
    md = fitcsvm(X,y,'KernelFunction','RBF');
else
    md = fitcsvm(X,y);
end

end

