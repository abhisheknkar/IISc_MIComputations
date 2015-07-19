% clc;clear all; close all;

subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
% Read cluster files for all batches for all subjects

% execRange = [4];
MIMat = {[],[],[],[]};

if exist(['MI/' mode_AAM '_Phoneme.mat'])
    load(['MI/' mode_AAM '_Phoneme.mat']);
end

for i = subjectstorun
    disp(subjects{i});
    MIMat{i} = [];
    PhonemeClusterPath = ['Outputs/Phonemes/' subjects{i} '/ClusterOutputs/'];
    AAMClusterPath = ['Outputs/' mode_AAM '/' subjects{i} '/ClusterOutputs/'];
    
    PhonemeFiles = dir([PhonemeClusterPath '*.txt']);
    AAMFiles = dir([AAMClusterPath '*.txt']);
    
    for j = 1:length(AAMFiles)
        [i,j]
        PhonemeCluster = dlmread([PhonemeClusterPath AAMFiles(j).name], '\n');
        AAMCluster = dlmread([AAMClusterPath AAMFiles(j).name], '\n'); 
        MIMat{i}(j) = computeMI(PhonemeCluster, AAMCluster);        
    end
end
mkdir('MI/AAM');
save(['MI/AAM/' mode_AAM '_Phoneme.mat'], 'MIMat');