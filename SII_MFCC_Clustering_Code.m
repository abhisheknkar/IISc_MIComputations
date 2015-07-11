% This code merges the features present in AAM and MFCC, clusters them and finds the MI
% between them and Phonemes

% clc;clear all; close all;
% Now we run the mini-batch KMeans Clustering for each subjects in batches
% of 100000
% execRange = [1];

ClusterInputSize = 1e5;
Clusters = 256;
% scheme = 'SII_MFCC';
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
load(['Outputs/' mode '/' trainwith '/' scheme(1:end-7) '/SII_Outputs.mat']);
load(['Outputs/MFCC/MFCCs.mat']);

disp('Mats loaded!');

SII_MFCCMat = {[],[],[],[]};

for i = 1:4
    SII_MFCCMat{i} = [SIIMat{i} MFCCMat{i}];
    disp('Mats merged!');

    for j = 1:size(SII_MFCCMat{i},2)
        col = SII_MFCCMat{i}(:,j);
        colnorm = (col - mean(col)) / max(eps,std(col));
        SII_MFCCMat{i}(:,j) = colnorm;
    end

    count = 0;
    ClusterInputDir = ['Outputs/' mode '/' trainwith '/' scheme '/' subjects{i} '/ClusterInputs'];
    ClusterOutputDir = ['Outputs/' mode '/' trainwith '/' scheme '/' subjects{i} '/ClusterOutputs'];
    
    mkdir(ClusterInputDir);
    mkdir(ClusterOutputDir);

    iterations = ceil(size(SII_MFCCMat{i},1)/ClusterInputSize); %No. of times to run
     
    for j = 1:iterations
        [i j]
        ClusterInput = SII_MFCCMat{i}(count+1:min(count+ClusterInputSize,size(SII_MFCCMat{i},1)),:);
        dlmwrite([ClusterInputDir '/' num2str(j) '.txt'], ClusterInput, ' '); 
        system(['python Cluster.py ' ClusterInputDir '/' num2str(j) '.txt ' num2str(Clusters) ' ' ClusterOutputDir '/' num2str(j) '.txt']);
        count = count + ClusterInputSize;
    end
end