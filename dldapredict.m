function [ eY ] = dldapredict( an,bn,X )
%DLDAPREDICT Summary of this function goes here
%   Detailed explanation goes here
% Input X~(m*d) an~(d*1) bn~(1*1)
% Output eY~(m*1)
g = X*an+ones(size(X,1),1)*bn;
eY = g>=0;
end

