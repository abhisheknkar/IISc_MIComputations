% Now we run the mini-batch KMeans Clustering for each subjects in batches
% of 200

% Optional to load
ClusterInputSize = 1e5;
Clusters = 256;
% scheme = 'SII_TIMITBN';
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
load(['Outputs/' mode '/' trainwith '/' scheme '/SII_Outputs.mat']);

for i = subjectstorun
    count = 0;
    ClusterInputDir = ['Outputs/' mode '/' trainwith '/' scheme '/' subjects{i} '/ClusterInputs/'];
    ClusterOutputDir = ['Outputs/' mode '/' trainwith '/' scheme '/' subjects{i} '/ClusterOutputs/'];
    
    mkdir(ClusterInputDir);
    mkdir(ClusterOutputDir);

    iterations = ceil(size(SIIMat{i},1)/ClusterInputSize); %No. of times to run
     
    for j = 1:iterations
        j
        ClusterInput = SIIMat{i}(count+1:min(count+ClusterInputSize,size(SIIMat{i},1)),:);
        dlmwrite([ClusterInputDir num2str(j) '.txt'], ClusterInput, ' '); 
        system(['python Cluster.py ' ClusterInputDir '/' num2str(j) '.txt ' num2str(Clusters) ' ' ClusterOutputDir '/' num2str(j) '.txt']);
        count = count + ClusterInputSize;
    end
end
