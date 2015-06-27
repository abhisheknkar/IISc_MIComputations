% Code to force 1-1 mapping between the AAM frames and the MFCC frames. 1
% time use
clc;clear all;close all;
tic
c_flag = 1;
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};

scheme = 'AAM';

AAMMat1to1 = {[],[],[],[]};
AAMMatUpsampled1to1 = {[],[],[],[]};
AAMSizeMat1to1 = {[],[],[],[]};

dirToSave = ['Outputs/' scheme '/'];
mkdir(dirToSave);
load([dirToSave 'AAMs.mat']);
load([dirToSave 'AAMUpsampled.mat']);
load('Outputs/MFCC/MFCCs.mat');
disp('AAMs loaded!');

execRange = [1:4];

%  Populating the lip coordinate matrix for each frame
for i = execRange
% Recording Level
    AAMUpsampled1to1{i} = [];    
    temp = [];
    last = 0;
    for j = 1:24  %All recordings
        [i,j]
 % Sentence level 
        for k = 1:100   %All sentences
%             Compare the sizes of the AAM sentence and the MFCC sentence.
%             If AAM > MFCC, choose only as many as required. Else, append
%             zeros
            sentence_number = (j-1)*100+k;
            if sentence_number > 2368
                break
            end
            num1 = AAMSizeMat{i}(sentence_number)*4;
            num2 = MFCCSizeMat{i}(sentence_number);
            if(num1 >= num2)
                temp(end+1:end+num2,:) = AAMMatUpsampled{i}(last+1:last+num2,:);
            else
                framesshort = num2 - num1;
                temp(end+1:end+num2,:) = [AAMMatUpsampled{i}(last+1:last+num1,:);zeros(framesshort,44)];
            end
            last = last + num1;
        end
    end
    AAMMatUpsampled1to1{i} = temp;
    save([dirToSave 'AAMUpsampled1to1.mat'], 'AAMMatUpsampled1to1');
end
toc
% 
% AAM_Clustering_Code2
% MI_Phoneme_AAM_Code