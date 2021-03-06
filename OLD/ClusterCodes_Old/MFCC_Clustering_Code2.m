% Now we run the mini-batch KMeans Clustering for each subjects in batches
% of 100000

% Optional to load
ClusterInputSize = 1e5;
Clusters = 256;
scheme = 'MFCC';
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
load(['Outputs/' scheme '/MFCCs.mat']);

for i = 1:4 
    count = 0;
    ClusterInputDir = ['Outputs/' scheme '/' subjects{i} '/ClusterInputs/'];
    ClusterOutputDir = ['Outputs/' scheme '/' subjects{i} '/ClusterOutputs/'];
    
    mkdir(ClusterInputDir);
    mkdir(ClusterOutputDir);

    iterations = ceil(size(MFCCMat{i},1)/ClusterInputSize); %No. of times to run
     
    for j = 1:iterations
        j
        ClusterInput = MFCCMat{i}(count+1:min(count+ClusterInputSize,size(MFCCMat{i},1)),:);
        dlmwrite([ClusterInputDir num2str(j) '.txt'], ClusterInput, ' '); 
        system(['python Cluster.py ' ClusterInputDir '/' num2str(j) '.txt ' num2str(Clusters) ' ' ClusterOutputDir '/' num2str(j) '.txt']);
        count = count + ClusterInputSize;
    end
end