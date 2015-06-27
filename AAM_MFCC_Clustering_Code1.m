% This code merges the features present in AAM and MFCC, clusters them and finds the MI
% between them and Phonemes

clc;clear all; close all;
% Now we run the mini-batch KMeans Clustering for each subjects in batches
% of 100000
execRange = [1:3];

ClusterInputSize = 1e5;
Clusters = 256;
scheme = 'AAM_MFCC';
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
load(['Outputs/AAM/AAMUpsampled1to1.mat']);
load(['Outputs/MFCC/MFCCs.mat']);

disp('Mats loaded!');

AAM_MFCCMat = {[],[],[],[]};

for i = execRange
    AAM_MFCCMat{i} = [AAMMatUpsampled1to1{i} MFCCMat{i}];
    disp('Mats merged!');

    count = 0;
    ClusterInputDir = ['Outputs/' scheme '/' subjects{i} '/ClusterInputs/'];
    ClusterOutputDir = ['Outputs/' scheme '/' subjects{i} '/ClusterOutputs/'];
    
    mkdir(ClusterInputDir);
    mkdir(ClusterOutputDir);

    iterations = ceil(size(AAM_MFCCMat{i},1)/ClusterInputSize); %No. of times to run
     
    for j = 1:iterations
        [i j]
        ClusterInput = AAM_MFCCMat{i}(count+1:min(count+ClusterInputSize,size(AAM_MFCCMat{i},1)),:);
        dlmwrite([ClusterInputDir num2str(j) '.txt'], ClusterInput, ' '); 
        system(['python Cluster.py ' ClusterInputDir '/' num2str(j) '.txt ' num2str(Clusters) ' ' ClusterOutputDir '/' num2str(j) '.txt']);
        count = count + ClusterInputSize;
    end
end