clear;
cd('F:\xiaokang_Tiantan\statistical_analysis');
gm=dir('*p2*.nii');
for i=1:size(gm,1)
    original=y_Read(strcat(gm(i).folder,'\',gm(i).name));
    abnormly=original>4|original<-4;
    roi=y_Read(strcat('F:\xiaokang_Tiantan\New_Mask\wnew_',gm(i).name(end-8:end-7)));
    roi(isnan(roi))=0;
    in_cancer_abnorm=roi.*abnormly;
    out_cancer_abnorm=(~roi).*abnormly;
    total_ratio(i,1)=sum(out_cancer_abnorm(:))/sum(roi(:));
    within_ratio(i,1)=sum(out_cancer_abnorm(:))/sum(in_cancer_abnorm(:));
end


   
 
 
