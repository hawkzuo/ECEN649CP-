function [ testerr ] = dldaTest(dA,dB,dFeatures,X,y)
%DLDATEST 
%  

iterations = size(dA,2);
testerr = ones(1,iterations);
for i=1:iterations
   cura = dA(1:i,i);
   curb = dB(:,i);
   eY = dldapredict(cura,curb,X(:,dFeatures(1:i,i)'));
   erate_i = sum(eY ~= y) / size(y,1);
   testerr(i)=erate_i;
end

end

