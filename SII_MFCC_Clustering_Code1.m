% This code merges the features present in AAM and MFCC, clusters them and finds the MI
% between them and Phonemes

clc;clear all; close all;
% Now we run the mini-batch KMeans Clustering for each subjects in batches
% of 100000
execRange = [1:4];

ClusterInputSize = 1e5;
Clusters = 256;
scheme = 'SII_MFCC';
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
load(['Outputs/SII_TIMITBN/SII_Outputs.mat']);
load(['Outputs/MFCC/MFCCs.mat']);

disp('Mats loaded!');

SII_MFCCMat = {[],[],[],[]};

for i = execRange
    SII_MFCCMat{i} = [SIIMat{i} MFCCMat{i}];
    disp('Mats merged!');

    count = 0;
    ClusterInputDir = ['Outputs/' scheme '/' subjects{i} '/ClusterInputs/'];
    ClusterOutputDir = ['Outputs/' scheme '/' subjects{i} '/ClusterOutputs/'];
    
    mkdir(ClusterInputDir);
    mkdir(ClusterOutputDir);

    iterations = ceil(size(SII_MFCCMat{i},1)/ClusterInputSize); %No. of times to run
     
    for j = 1:iterations
        [i j]
        ClusterInput = SII_MFCCMat{i}(count+1:min(count+ClusterInputSize,size(SII_MFCCMat{i},1)),:);
        dlmwrite([ClusterInputDir num2str(j) '.txt'], ClusterInput, ' '); 
        system(['python Cluster.py ' ClusterInputDir '/' num2str(j) '.txt ' num2str(Clusters) ' ' ClusterOutputDir '/' num2str(j) '.txt']);
        count = count + ClusterInputSize;
    end
end