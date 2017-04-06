function [ md ] = kNN( X,y,k)
%KNN Summary of this function goes here
%   Detailed explanation goes here
md = fitcknn(X,y,'NumNeighbors',k);
end

