function [Features]= Feature_Extraction(data)
%Input Data should be thresholded data
%     Downsample_Data=downsample(data,2);
%     [m,n]=size(Downsample_Data);
%     Der1=zeros(m,n);
% 
%     for i=1:m-1
%         Der1(i,1)=(Downsample_Data(i+1)-Downsample_Data(i))/32;
%     end
    
    RMS=rms(data);
    
    Std=std(data);
    
    Mean=mean(data);
    
    [~,max_idx]=max(data);
    
%     Features=[Downsample_Data; RMS; Std; Mean; max_idx; Der1];
    Features=[data; RMS; Std; Mean; max_idx];
end
