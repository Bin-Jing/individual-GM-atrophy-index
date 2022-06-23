clear;
cd('F:\xiaokang_Tiantan\result\right\standardspace_Brain');
underlay=dir('*.nii');
cd('F:\xiaokang_Tiantan\result\right\combined_atrophy_ROI');
overlay=dir('*.nii');
for i=1:size(underlay)
h=y_Call_spm_orthviews(strcat(overlay(i).folder,'\',overlay(i).name),0,0,20,18,strcat(underlay(i).folder,'\',underlay(i).name),y_AFNI_ColorMap(6));
pause(10);
print(h,underlay(i).name(1:end-4),'-dtiff','-r200');
close(h);
end
