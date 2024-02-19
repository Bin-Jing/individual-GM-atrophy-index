clear;
[wsex,sheader]=y_Read('E:\tourette\smri_9\model\beta_0002.nii');
wage=y_Read('E:\tourette\smri_9\model\beta_0003.nii');
wtiv=y_Read('E:\tourette\smri_9\model\beta_0004.nii');
cons=y_Read('E:\tourette\smri_9\model\beta_0001_new.nii');
res_ms=y_Read('E:\tourette\smri_9\model\std_res.nii');
basis_mask=y_Read('E:\tourette\smri_9\model\Masked_BN.nii');
% cd('F:\xiaokang_Tiantan\New_Mask');
% mask=dir('w*.nii');
cd('E:\tourette\smri_9\model\torre');
nii=dir('*.nii');
test=xlsread('E:\tourette\smri_9\model\torre.xlsx');
for i=1:size(nii,1)
expected=test(i,1).*wsex+test(i,2).*wage+test(i,3).*wtiv+cons;
real=y_Read(strcat(nii(i).folder,'\',nii(i).name));
wscore=(real-expected)./res_ms;
% ind_mask=y_Read(strcat(mask(i).folder,'\',mask(i).name));
% ind_mask(isnan(ind_mask))=0;
new_mask=basis_mask;%|ind_mask;
wscore=wscore.*new_mask;
wscore(isnan(wscore))=0;
y_Write(wscore,sheader,strcat('E:\tourette\smri_9\model\individual_',nii(i).name));
end