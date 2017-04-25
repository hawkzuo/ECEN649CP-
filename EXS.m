function [ minErrors,outFeature,totalA,totalB ] = EXS( X,y,upperD,methodNO )
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



minErrors = zeros(1,upperD);  
outFeature = zeros(upperD,upperD);
counter = 1;
if methodNO == 0 
    while counter <= upperD  
        fprintf('Current iteration is %d\n',counter)
        allP = nchoosek(Indexes,counter);
        gMin=100;
        if(size(allP,1) > 100000000)
            return
        end
        for i=1:size(allP,1)
            %newX=X(:,allP(i,:));
            [cura,curb]=dlda(X(:,allP(i,:)),y);
            eY = dldapredict(cura,curb,X(:,allP(i,:)));
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
    while counter <= upperD  
        fprintf('Current iteration is %d\n',counter)
        allP = nchoosek(Indexes,counter);
        gMin=100;
        if(size(allP,1) > 100000)
            return
        end
        for i=1:size(allP,1)
            
            %newX=X(:,allP(i,:));
            Model=kNN(X(:,allP(i,:)),y,3);
            eY = kNNpredict(Model,X(:,allP(i,:)));
            erate_i = sum(eY ~= y) / m; 
            if erate_i < gMin
                gMin = erate_i;
                minErrors(counter)=gMin;
                outFeature(1:counter,counter)=allP(i,:)';
                fprintf('%d sub iterations to go\n',size(allP,1)-i)
            end
        end
        counter=counter+1;           
    end

elseif methodNO == 2
    while counter <= upperD  
        fprintf('Current iteration is %d\n',counter)
        allP = nchoosek(Indexes,counter);
        gMin=100;
        if(size(allP,1) > 100000)
            return
        end
        for i=1:size(allP,1)
            fprintf('%d sub iterations to go\n',size(allP,1)-i)
            %newX=X(:,allP(i,:));
            Model=SVMfit(X(:,allP(i,:)),y,0);
            eY = SVMpredict(Model,X(:,allP(i,:)));
            erate_i = sum(eY ~= y) / m; 
            if erate_i < gMin
                gMin = erate_i;
                minErrors(counter)=gMin;
                outFeature(1:counter,counter)=allP(i,:)';
                
            end
        end
        counter=counter+1;           
    end    

end




end


