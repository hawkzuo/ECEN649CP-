function [ a,b ] = dlda(X,y)
%DLDA Summary of this function goes here
%   Detailed explanation goes here
% Input: X`(m,d) y~(m,1)   
% Output: a`(d,1) b`(1,1)

% Use find (y== 0) Or y==0
X0 = X(y==0,:);
X1 = X(y==1,:);
n0 = size(X0,1);    n1 = size(X1,1);

miu0 = transpose(sum(X0)) / n0;
miu1 = transpose(sum(X1)) / n1;
Z0 = X0 - ones(n0,1)*miu0';
Z1 = X1 - ones(n1,1)*miu1';
sigma0 = Z0'*Z0/ (n0-1);
sigma1 = Z1'*Z1/ (n1-1);
sigma = ((n0-1)*sigma0+(n1-1)*sigma1)/(n0+n1-2);

e_sigmaD = diag(diag(sigma));
a = e_sigmaD \ (miu1-miu0);
b = -0.5 * transpose(miu1-miu0) *(e_sigmaD \ (miu1+miu0)) + log(n1/n0);

end

