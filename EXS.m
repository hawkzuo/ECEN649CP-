function [ totalA,totalB,minErrors,outFeature ] = EXS( X,y,upperD,methodNO )
%EXS Summary of this function goes here
% This function perform the Exhausted Search on the given
% data (X,y), returns upperD-dimentional arrays that contains the 
% selected features by method 'methodNO'
% Return: An->totalA, Bn->totalB, err->minErrors, ListOrder->outFeature
%   Detailed explanation goes here

m=size(X,1);
d=size(X,2);
totalA=zeros(upperD,upperD);  totalB=zeros(1,upperD);
Indexes = 1:d;

if methodNO == 0
    minErrors = zeros(1,upperD);  
    outFeature = zeros(upperD,upperD);
    counter = 1;
    
    while counter <= upperD  
        fprintf('Current iteration is %d\n',counter)
        allP = nchoosek(Indexes,counter);
        gMin=100;
        for i=1:size(allP,1)
            newX=X(:,allP(i,:));
            [cura,curb]=dlda(newX,y);
            eY = dldapredict(cura,curb,newX);
            erate_i = sum(eY ~= y) / m; 
            if erate_i < gMin
                gMin = erate_i;
                totalA(1:counter,counter)=cura;
                totalB(counter)=curb;
                minErrors(counter)=gMin;
                outFeature(1:counter,counter)=allP(i,:)';
            end
        end
        counter=counter+1;       
    end
    
elseif methodNO == 1       
    
end




end


