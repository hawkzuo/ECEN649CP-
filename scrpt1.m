clear all

%Load Training Data
Traindata=readTrain();
% summary(T);   size(T);
% T.Properties
labels = Traindata.Properties.VariableNames;
features = labels(1,2:end-1);
rawX=table2array(Traindata);    rawn = size(rawX,2);
%Train Data & labels
X=rawX(:,2:rawn-1);     y = rawX(:,rawn);
m = size(X,1);  n = size(X,2);

%Load Testing Data
Testdata=readTest();
rawTX=table2array(Testdata);    rawtn = size(rawTX,2);
%Test Data & labels
TX=rawTX(:,2:rawtn-1);     Ty = rawTX(:,rawtn);
mt=size(TX,1);  nt=size(TX,2);



%Exhaustive Search
disp('1D:')
performance1D = zeros(2,1);
g1DMin=100; g1DIndex = -1;
%First try on the 1d-feature situation:
for i=1:n
    newX = X(:,i);
    [an,bn]=dlda(newX,y);
    eY = dldapredict(an,bn,newX);
    erate_i = sum(eY ~= y) / m;    
    if erate_i < g1DMin
        g1DMin = erate_i;
        g1DIndex = i;
        A1d = an;   B1d = bn;
    end
end

% eTestY=dldapredict(A1d,B1d,TX(:,g1DIndex));
% testError1D = sum(eTestY ~= Ty) / mt;
% performance1D(1)=g1DMin;    performance1D(2)=testError1D;

OneDLabel = features{g1DIndex};
disp(OneDLabel)

disp('2D:')
% %Then try on the 2d-feature situation:
performance2D = zeros(2,1);
g2DMin=100;g2DRow=-1;g2DCol=-1;
for i=1:n
    for j=i+1:n
        newX = X(:,[i,j]);
        [an,bn]=dlda(newX,y);
        eY = dldapredict(an,bn,newX);
        erate_ij = sum(eY ~= y) / m;
        if erate_ij < g2DMin
            g2DMin = erate_ij;
            g2DRow=i;   g2DCol=j;
            A2d=an;     B2d=bn;
        end
    end
end

% eTestY=dldapredict(A2d,B2d,TX(:,[g2DRow,g2DCol]));
% testError2D = sum(eTestY ~= Ty) / mt;
% performance2D(1)=g2DMin;    performance2D(2)=testError2D;

TwoDLabel2 = features{g2DRow};
TwoDLabel1 = features{g2DCol};
disp(TwoDLabel1)
disp(TwoDLabel2)

disp('3D:')
%Finally try on the 2d-feature situation:
g3DMin=100;g3DRow=-1;g3DCol=-1;g3DK=-1;
performance3D = zeros(2,1);
for i=1:n
    for j=i+1:n        
        for k=j+1:n
            newX = X(:,[i,j,k]);
            [an,bn]=dlda(newX,y);
            eY = dldapredict(an,bn,newX);
            erate_ijk = sum(eY ~= y) / m;       
            if erate_ijk < g3DMin
                g3DMin = erate_ijk;
                g3DRow=i;g3DCol=j;g3DK=k;
                A3d=an; B3d=bn;
            end
        end
    end
end

ThreeDLabel2 = features{g3DRow};
ThreeDLabel1 = features{g3DCol};
ThreeDLabel3 = features{g3DK};
disp(ThreeDLabel1)
disp(ThreeDLabel2)
disp(ThreeDLabel3)
        


%Sequential forward search
[DLDAan,DLDAbn,DLDAerr,DLDAout]=SFS(X,y,8,0);
for i=1:8
    features{DLDAout(i)}
end




















