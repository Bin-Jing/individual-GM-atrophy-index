clear;
[wsex,sheader]=y_Read('F:\Healthy_control_SMRI\health_model\GM\beta_0002.nii');
wage=y_Read('F:\Healthy_control_SMRI\health_model\GM\beta_0003.nii');
wedu=y_Read('F:\Healthy_control_SMRI\health_model\GM\beta_0004.nii');
%res=y_Read('F:\Healthy_control_SMRI\health_model\WM\beta_0001.nii');
res_ms=y_Read('F:\Healthy_control_SMRI\health_model\GM\std_res.nii');
basis_mask=y_Read('F:\Healthy_control_SMRI\Reslice_GM02_Mask.nii');
cd('F:\xiaokang_Tiantan\New_Mask');
mask=dir('w*.nii');
cd('F:\xiaokang_Tiantan\GM_volume');
nii=dir('s4*.nii');
test=xlsread('F:\xiaokang_Tiantan\statistical_analysis\nuisance.xlsx');
for i=1:size(nii,1)
expected=test(i,1).*wsex+test(i,2).*wage+test(i,3).*wtiv;%+res;%without res
real=y_Read(strcat(nii(i).folder,'\',nii(i).name));
wscore=(real-expected)./res_ms;
ind_mask=y_Read(strcat(mask(i).folder,'\',mask(i).name));
ind_mask(isnan(ind_mask))=0;
new_mask=basis_mask|ind_mask;
wscore=wscore.*new_mask;
y_Write(wscore,sheader,strcat('F:\xiaokang_Tiantan\statistical_analysis\individual_',nii(i).name));
end