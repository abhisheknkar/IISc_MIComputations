% clc;clear all; close all;
tic
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
% Read cluster files for all batches for all subjects

% scheme = 'SII_TIMITBN';
MIMat = {[],[],[],[]};
mkdir(['MI/' mode '/' trainwith '/']);
if exist(['MI/' mode '/' trainwith '/' scheme '_Phoneme.mat'])
    load(['MI/' mode '/' trainwith '/' scheme '_Phoneme.mat']);
end

for i = subjectstorun
    MIMat{i} = [];
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
save(['MI/' mode '/' trainwith '/' scheme '_Phoneme.mat'], 'MIMat');
toc