% This code merges the features present in AAM and MFCC, clusters them and finds the MI
% between them and Phonemes

% clc;clear all; close all;

Clusters = 256;

subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
AAM_MFCCMat = {[],[],[],[]};

for i = subjectstorun
    disp(subjects{i});
    
    ClusterInputDir = ['Outputs/AAM/' mode_AAM '/' subjects{i} '/ClusterInputs/'];
    ClusterOutputDir = ['Outputs/AAM/' mode_AAM '/' subjects{i} '/ClusterOutputs/'];
    mkdir(ClusterOutputDir);

    iterations = size(dir([ClusterInputDir '*.txt']),1);
    for j = 1:iterations
        A = dlmread([ClusterInputDir num2str(j) '.txt'], ' ');
        A = colnorm(A);
        dlmwrite([ClusterInputDir num2str(j) '.txt'], A, ' ');
        
        system(['python Cluster.py ' ClusterInputDir '/' num2str(j) '.txt ' num2str(Clusters) ' ' ClusterOutputDir '/' num2str(j) '.txt']);
    end
end