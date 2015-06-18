% Now we run the mini-batch KMeans Clustering for each subjects in batches
% of 200

% Optional to load
load('Outputs/Phonemes/PhonemeMat.mat');
ClusterInputSize = 1e5;
Clusters = 256;
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};

for i = 1:4 
    count = 0;
    ClusterOutputDir = ['Outputs/Phonemes/' subjects{i} '/ClusterOutputs/'];
    
    mkdir(ClusterOutputDir);

    iterations = ceil(size(PhonemeMat{i},2)/ClusterInputSize); %No. of times to run
    for j = 1:iterations
        j
        ClusterInput = PhonemeMat{i}(:,count+1:min(count+ClusterInputSize,size(PhonemeMat{i},2)));
        dlmwrite([ClusterOutputDir num2str(j) '.txt'], ClusterInput, '\n'); 
%         system(['python Cluster.py ' ClusterInputDir '/' num2str(j) '.txt ' num2str(Clusters) ' ' ClusterOutputDir '/' num2str(j) '.txt']);
    count = count + ClusterInputSize;
    end
end