% clc;clear all; close all;
tic
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
% Read cluster files for all batches for all subjects

% execRange = [1];
MIMat = {[],[],[],[]};
% scheme = 'SII_MFCC';

if exist('MI/SII_MFCC_Phoneme.mat') 
    load('MI/SII_MFCC_Phoneme.mat');
end
for i = subjectstorun
    MIMat{i} = [];
    PhonemeClusterPath = ['Outputs/Phonemes/' subjects{i} '/ClusterOutputs/'];
    AAMClusterPath = ['Outputs/' mode '/' trainwith '/' scheme '/' subjects{i} '/ClusterOutputs/'];
    
    PhonemeFiles = dir([PhonemeClusterPath '*.txt']);
    AAMFiles = dir([AAMClusterPath '*.txt']);
    for j = 1:length(AAMFiles)
        [i,j]
        PhonemeCluster = dlmread([PhonemeClusterPath AAMFiles(j).name], '\n');
        AAMCluster = dlmread([AAMClusterPath AAMFiles(j).name], '\n'); 
        MIMat{i}(j) = computeMI(PhonemeCluster, AAMCluster);        
    end
end
mkdir('MI/');
save(['MI/' mode '/' trainwith '/' scheme '_Phoneme.mat'], 'MIMat');
toc