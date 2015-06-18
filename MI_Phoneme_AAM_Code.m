clc;clear all; close all;
tic
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
% Read cluster files for all batches for all subjects

scheme = 'AAM';
% load('MI/AAM_Phoneme.mat');
MIMat = {[],[],[],[]};
for i = 1:4
    PhonemeClusterPath = ['Outputs/Phonemes/' subjects{i} '/ClusterOutputs/'];
    AAMClusterPath = ['Outputs/' scheme '/' subjects{i} '/ClusterOutputs/'];
    
    PhonemeFiles = dir([PhonemeClusterPath '*.txt']);
    AAMFiles = dir([AAMClusterPath '*.txt']);
    
    for j = 1:length(AAMFiles)
        i,j
        PhonemeCluster = dlmread([PhonemeClusterPath AAMFiles(j).name], '\n');
        AAMCluster = dlmread([AAMClusterPath AAMFiles(j).name], '\n'); 
        MIMat{i}(j) = computeMI(PhonemeCluster, AAMCluster);        
    end
end
mkdir('MI/');
save('MI/AAM_Phoneme.mat', 'MIMat');
toc