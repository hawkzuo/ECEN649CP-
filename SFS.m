function [ minErrors,outFeatureExpand,totalA,totalB ] = SFS( X,y,upperD,methodNO )
%SFS Summary of this function goes here
% This function perform the Sequential Forward Search on the given
% data (X,y), returns upperD-dimentional arrays that contains the 
% selected features by method 'methodNO'
% Return: An->totalA, Bn->totalB, err->minErrors, ListOrder->outFeature
%   Detailed explanation goes here

m=size(X,1);
d=size(X,2);

totalA=zeros(upperD,upperD);  totalB=zeros(1,upperD);
%Initialize MinimumError;OutputFeatures;GlobalCounter;GlobalMinimumError
minErrors = zeros(1,upperD);  
outFeature = zeros(1,upperD);
outFeatureExpand = zeros(upperD,upperD);
counter = 0;

if methodNO == 0
    %gMin=100;
    while counter < upperD 
        %Choice 1: choose the min index
        gMin=100;
        levelopt = -1;
        for i=1:d            
            if(sum(ismember(outFeature,i)) > 0)                
            else
                if counter == 0
                    newX=X(:,i);
                else
                    newX=X(:,[outFeature(:,1:counter),i]);
                end           
                [cura,curb]=dlda(newX,y);
                eY = dldapredict(cura,curb,newX);
                erate_i = sum(eY ~= y) / m;       
                if erate_i < gMin
                    %Choice2: always choose the biggest index
                    levelopt = i;
                    gMin = erate_i;
                    totalA(1:1+counter,counter+1)=cura;
                    totalB(counter+1)=curb;
                    %A3d=an; B3d=bn;
                end              
            end
        end        
        if levelopt == -1
            break
        end
        minErrors(counter+1)=gMin;
        outFeature(counter+1)=levelopt;
        counter=counter+1;       
    end
elseif methodNO == 1    
    %gMin=100;
    while counter < upperD 
        gMin=100;
        levelopt = -1;
        for i=1:d            
            if(sum(ismember(outFeature,i)) > 0)                
            else
                if counter == 0
                    newX=X(:,i);
                else
                    newX=X(:,[outFeature(:,1:counter),i]);
                end     
                Model=kNN(newX,y,3);
                eY = kNNpredict(Model,newX);                
                erate_i = sum(eY ~= y) / m;       
                if erate_i <= gMin
                    %Choice2: always choose the biggest index
                    levelopt = i;
                    gMin = erate_i;
                end              
            end
        end        
        if levelopt == -1
            break
        end
        minErrors(counter+1)=gMin;
        outFeature(counter+1)=levelopt;
        counter=counter+1;       
    end    
 
elseif methodNO == 2
    
    while counter < upperD
        gMin = 100;
        levelopt = -1;
        fprintf('%d dimension\n',counter)
        for i=1:d         
            fprintf('%d sub iterations to go\n',d-i)
            if(sum(ismember(outFeature,i)) > 0)                
            else
                if counter == 0
                    newX=X(:,i);
                else
                    newX=X(:,[outFeature(:,1:counter),i]);
                end     
                Model=SVMfit(newX,y,1);
                eY = SVMpredict(Model,newX);                
                erate_i = sum(eY ~= y) / m;       
                if erate_i < gMin
                    %Choice2: always choose the biggest index
                    levelopt = i;
                    gMin = erate_i;
                end              
            end
        end        
        if levelopt == -1
            break
        end
        minErrors(counter+1)=gMin;
        outFeature(counter+1)=levelopt;
        counter=counter+1;       
    end     
    
    
    
    
    
end
for i=1:upperD
    outFeatureExpand(1:i,i) = outFeature(1,1:i);
end
end

