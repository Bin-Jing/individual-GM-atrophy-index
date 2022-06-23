clear;
whole=y_Read('F:\Healthy_control_SMRI\health_model\RS_mask_ICV.nii');
[x0,y0,z0]=find(whole==1);
total_left=0;
total_right=0;

for m=1:size(x0,1)
if x0(m)>=91
        total_left=total_left+1;
else
        total_right=total_right+1;
end
end

cd('F:\xiaokang_Tiantan\statistical_analysis');
gm=dir('*p1*.nii');
for i=1:size(gm,1)
    original=y_Read(strcat(gm(i).folder,'\',gm(i).name));
    thicken=original>4;
    atrophy=original<-4;
    [x1,y1,z1]=find(thicken==1);
    [x2,y2,z2]=find(atrophy==1);
    thick_num_left(i)=0;
    thick_num_right(i)=0;
    atrophy_num_left(i)=0;
    atrophy_num_right(i)=0;
    
    for j=1:size(x1,1)
    if x1(j)>=91
        thick_num_left(i)=thick_num_left(i)+1;
    else
        thick_num_right(i)=thick_num_right(i)+1;
    end
    end
 
    for k=1:size(x2,1)
    if x2(k)>=91
        atrophy_num_left(i)=atrophy_num_left(i)+1;
    else
        atrophy_num_right(i)=atrophy_num_right(i)+1;
    end
    end
    
    abnormal_index(i,1)=thick_num_left(i)/total_left;
    abnormal_index(i,2)=thick_num_right(i)/total_right;
    abnormal_index(i,3)=atrophy_num_left(i)/total_left;
    abnormal_index(i,4)=atrophy_num_right(i)/total_right;
    abnormal_index(i,5)=(thick_num_left(i)+atrophy_num_left(i))/total_left;
    abnormal_index(i,6)=(thick_num_right(i)+atrophy_num_right(i))/total_right;
end
data=xlsread('F:\xiaokang_Tiantan\model.xlsx');
pos=data(:,11);
for n=1:size(pos,1)
if(pos(n)==1) 
    sorted_abnormal_index(n,1)=abnormal_index(n,1);
    sorted_abnormal_index(n,2)=abnormal_index(n,2);
    sorted_abnormal_index(n,3)=abnormal_index(n,3);
    sorted_abnormal_index(n,4)=abnormal_index(n,4);
    sorted_abnormal_index(n,5)=abnormal_index(n,5);
    sorted_abnormal_index(n,6)=abnormal_index(n,6);
    
else
    sorted_abnormal_index(n,1)=abnormal_index(n,2);
    sorted_abnormal_index(n,2)=abnormal_index(n,1);
    sorted_abnormal_index(n,3)=abnormal_index(n,4);
    sorted_abnormal_index(n,4)=abnormal_index(n,3);
    sorted_abnormal_index(n,5)=abnormal_index(n,6);
    sorted_abnormal_index(n,6)=abnormal_index(n,5);
end
end