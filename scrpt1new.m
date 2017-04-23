clearvars

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
fprintf('DLDA Result:\n');
fprintf('DLDA Exhaustive Search Result:\n');
[DLDA_err,DLDA_feature,DLDA_a,DLDA_b]=EXS(X,y,3,0)
%Perform on Test Data
DLDA_brute_testerror = dldaTest(DLDA_a,DLDA_b,DLDA_feature,TX,Ty)
%Sequential Forward search
fprintf('DLDA Sequential Forward Search Result:\n');
[DLDAerr,DLDAout,DLDAan,DLDAbn]=SFS(X,y,8,0)
%Perform on Test Data
DLDA_SFS_testerror = dldaTest(DLDAan,DLDAbn,DLDAout,TX,Ty)

%Get Str output
fprintf('DLDA Feature Selected:\n');
DLDA_brute_sel_fs = cell(3);
for i=1:3
    DLDA_brute_sel_fs(1:i,i) = features(1,DLDA_feature(1:i,i));
end
DLDA_SFS_sel_fs = cell(8);
for i=1:8
    DLDA_SFS_sel_fs(1:i,i) = features(1,DLDAout(1:i,i));
end
disp(DLDA_brute_sel_fs)
disp(DLDA_SFS_sel_fs)





%Sequential forward search
fprintf('3NN Result:\n');
fprintf('3NN Sequential Forward Search Result:\n');
[NNerr,NNfeature]=SFS(X,y,8,1)
%Perform on Test Data
kNN_SFS_testerror = kNNTest(3,NNfeature,X,y,TX,Ty )
%Exhaustive Search
fprintf('3NN Exhaustive Search Result:\n');
[NN_err,NN_feature]=EXS(X,y,3,1)
%Perform on Test Data
kNN_brute_testerror = kNNTest( 3,NN_feature,X,y,TX,Ty )

%Get Str output
fprintf('3NN Feature Selected:\n');
kNN_brute_sel_fs = cell(3);
for i=1:3
    kNN_brute_sel_fs(1:i,i) = features(1,NN_feature(1:i,i));
end
kNN_SFS_sel_fs = cell(8);
for i=1:8
    kNN_SFS_sel_fs(1:i,i) = features(1,NNfeature(1:i,i));
end
disp(kNN_brute_sel_fs)
disp(kNN_SFS_sel_fs)




