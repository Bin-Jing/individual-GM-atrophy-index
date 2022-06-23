clear;
data=xlsread('F:\xiaokang_Tiantan\model.xlsx');
for j=1:10
feature=data(:,1:14);
label=data(:,17);
%label(find(label==2))=0;
label(find(label>0))=1;
combine=[feature,~label];
[size1,size2] = size(combine);
T = sum(combine(:,size2)); % Number of data in positive (majority) class
N = 100; % SMOTE N%
k = 6; % k for SMOTE nearest neighbor
Synthesis_new= SMOTE(combine,T,N,k); % Newly generated samples
Synthesis=[combine;Synthesis_new];
Synthesis(:,10:14)=round(Synthesis(:,10:14));
for i=1:size(label,1)
train_feature=Synthesis(:,1:14);
train_feature(i,:)=[];
train_label=Synthesis(:,15);
train_label(i,:)=[];
test_feature=Synthesis(i,1:14);
model_svm=fitcsvm(train_feature,train_label,'Standardize',true,'KernelFunction','linear');
predict_svm(i)=predict(model_svm,test_feature);
model_rf = fitensemble(train_feature,train_label,'bag',150,'tree','type','Classification');
predict_rf(i) = predict(model_rf,test_feature);
model_lr=fitglm(train_feature,train_label,'Distribution','binomial');
predict_lr(i)=round(predict(model_lr,test_feature));
end
accuracy_svm(j)=size(find(~label-predict_svm'==0),1)/size(label,1);
accuracy_rf(j)=size(find(~label-predict_rf'==0),1)/size(label,1);
accuracy_lr(j)=size(find(~label-predict_lr'==0),1)/size(label,1);
end