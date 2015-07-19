subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
% Read cluster files for all batches for all subjects

MIMat = {[],[],[],[]};
for i = subjectstorun
    disp(subjects{i});
    PhonemeClusterPath = ['Outputs/Phonemes/' subjects{i} '/ClusterOutputs/'];
    MFCCClusterPath = ['Outputs/MFCC/' subjects{i} '/ClusterOutputs/'];
    
    PhonemeFiles = dir([PhonemeClusterPath '*.txt']);
    MFCCFiles = dir([MFCCClusterPath '*.txt']);
    
    for j = 1:length(MFCCFiles)
        PhonemeCluster = dlmread([PhonemeClusterPath MFCCFiles(j).name], '\n');
        MFCCCluster = dlmread([MFCCClusterPath MFCCFiles(j).name], '\n'); 
        MIMat{i}(j) = computeMI(PhonemeCluster, MFCCCluster);        
    end
end
mkdir('MI/');
save('MI/MFCC_Phoneme.mat', 'MIMat');