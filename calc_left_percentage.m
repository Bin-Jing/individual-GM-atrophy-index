cd('G:\xiaokang_Tiantan\result\left_glioma\glioma_mask');
mask=dir('w*.nii');
cd('G:\xiaokang_Tiantan\result\left_glioma\gm');
gm=dir('*p1*.nii');
sum=zeros(181,217,181);
for i=1:size(gm,1)
    [original,header]=y_Read(strcat(gm(i).folder,'\',gm(i).name));
    glioma=y_Read(strcat(mask(i).folder,'\',mask(i).name));
    glioma(isnan(glioma))=0;
    abnormality=original>3|original<-3;
    abnormality=abnormality.*(~glioma);
    sum=sum+abnormality;
end
result=sum./size(gm,1);
for x=1:size(result,1)
    for y=1:size(result,2)
        for z=1:size(result,3)
            if result(x,y,z)<0.6 result(x,y,z)=0;
            end
        end
    end
end
y_Write(result,header,'C:\Users\JING\Desktop\left.nii')
