% clc;clear all; close all;
tic
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
% Read cluster files for all batches for all subjects

MIMat = {[],[],[],[]};

if exist(['MI/AAM/' mode_AAM '_Phoneme.mat'])
    load(['MI/AAM/' mode_AAM '_Phoneme.mat']);
end
for i = subjectstorun
    disp(subjectstorun{i});
    MIMat{i} = [];
    PhonemeClusterPath = ['Outputs/Phonemes/' subjects{i} '/ClusterOutputs/'];
    AAMClusterPath = ['Outputs/AAM' mode_AAM '/' subjects{i} '/ClusterOutputs/'];
    
    PhonemeFiles = dir([PhonemeClusterPath '*.txt']);
    AAM_MFCC_Files = dir([AAMClusterPath '*.txt']);
    
    for j = 1:length(AAM_MFCC_Files)
        PhonemeCluster = dlmread([PhonemeClusterPath AAM_MFCC_Files(j).name], '\n');
        AAMCluster = dlmread([AAMClusterPath AAM_MFCC_Files(j).name], '\n'); 
        MIMat{i}(j) = computeMI(PhonemeCluster, AAMCluster);        
    end
end
mkdir('MI/AAM/');
save(['MI/AAM/' mode_AAM '_Phoneme.mat'], 'MIMat');
toc