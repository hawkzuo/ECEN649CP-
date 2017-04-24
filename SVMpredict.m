function [ eY ] = SVMpredict( md,testX )
%SVMPREDICT Summary of this function goes here
%   Detailed explanation goes here
eY = predict(md,testX);
end

