clc;clear all;close all;
tic
c_flag = 1;
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
AAMMat = {[],[],[],[]};
AAMSizeMat = {[],[],[],[]};
%%  Populating the lip coordinate matrix for each frame
for i = 1
    i
    for j = 1   %All recordings
        rec_folder = ['../../X/' subjects{i} '/AAM/Rec' num2str(j)];
        
        for k = 1:100   %All sentences
            sentence_number = (j-1)*100 + k;
            if exist([rec_folder num2str(sentence_number)],'dir')
                % Get frames
                
            end

            if(size(sentence_list,1)
            
%         end       
    end
end
toc