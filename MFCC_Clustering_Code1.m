% This code creates reads all the mfcc files of all subjects and dumps them into a cell
clc;clear all;close all;
tic
addpath('voicebox/');
scheme = 'MFCC';
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
MFCCMat = {[],[],[],[]};
MFCCSizeMat = {[],[],[],[]};

for i = 1:4
    for j = 1:24
        j
        folder_path = ['../' scheme '/' subjects{i} '/SII_Inputs_Split/Rec' num2str(j) '/']; 
        for k = 1:100
            filename = [folder_path num2str((j-1)*100+k) '.mfc'];
            if exist(filename)
                readOutput = readhtk(filename);
                MFCCMat{i}(end+1:end+size(readOutput,1),:) = readOutput;
                MFCCSizeMat{i}((j-1)*100+k) = size(readOutput,1);
            else
                MFCCSizeMat{i}((j-1)*100+k) = 0;
            end
        end
    end
end
dirToSave = ['Outputs/' scheme '/'];
mkdir(dirToSave);
save([dirToSave 'MFCCs.mat'], 'MFCCMat', 'MFCCSizeMat');
toc