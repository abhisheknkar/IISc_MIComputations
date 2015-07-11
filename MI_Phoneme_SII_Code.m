% clc;clear all; close all;
tic
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
% Read cluster files for all batches for all subjects

% scheme = 'SII_TIMITBN';
% load('MI/MFCC_Phoneme.mat');
MIMat = {[],[],[],[]};
for i = 1:4
    PhonemeClusterPath = ['Outputs/Phonemes/' subjects{i} '/ClusterOutputs/'];
    MFCCClusterPath = ['Outputs/' mode '/' trainwith '/' scheme '/' subjects{i} '/ClusterOutputs/'];
    
    PhonemeFiles = dir([PhonemeClusterPath '*.txt']);
    MFCCFiles = dir([MFCCClusterPath '*.txt']);
    
    for j = 1:length(MFCCFiles)
        [i,j]
        PhonemeCluster = dlmread([PhonemeClusterPath MFCCFiles(j).name], '\n');
        MFCCCluster = dlmread([MFCCClusterPath MFCCFiles(j).name], '\n'); 
        MIMat{i}(j) = computeMI(PhonemeCluster, MFCCCluster);        
    end
end
mkdir(['MI/' mode '/' trainwith '/']);
save(['MI/' mode '/' trainwith '/' scheme '_Phoneme.mat'], 'MIMat');
toc