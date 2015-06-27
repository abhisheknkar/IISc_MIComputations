% clc;clear all; close all;
tic
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
% Read cluster files for all batches for all subjects

execRange = [2];
MIMat = {[],[],[],[]};
scheme = 'AAM_MFCC';

load('MI/AAM_MFCC_Phoneme.mat');
for i = execRange
    MIMat{i} = [];
    PhonemeClusterPath = ['Outputs/Phonemes/' subjects{i} '/ClusterOutputs/'];
    AAMClusterPath = ['Outputs/' scheme '/' subjects{i} '/ClusterOutputs/'];
    
    PhonemeFiles = dir([PhonemeClusterPath '*.txt']);
    AAM_MFCC_Files = dir([AAMClusterPath '*.txt']);
    
    for j = 1:length(AAM_MFCC_Files)
        [i,j]
        PhonemeCluster = dlmread([PhonemeClusterPath AAM_MFCC_Files(j).name], '\n');
        AAMCluster = dlmread([AAMClusterPath AAM_MFCC_Files(j).name], '\n'); 
        MIMat{i}(j) = computeMI(PhonemeCluster, AAMCluster);        
    end
end
mkdir('MI/');
save('MI/AAM_MFCC_Phoneme.mat', 'MIMat');
toc