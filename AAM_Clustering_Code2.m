% Now we run the mini-batch KMeans Clustering for each subjects in batches
% of 100000

% Optional to load
ClusterInputSize = 1e5;
Clusters = 256;
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
load(['Outputs/AAM_all/AAMUpsampled.mat']);
% execRange = [1:3];
for i = subjectstorun
    count = 0;
    ClusterInputDir = ['Outputs/' mode_AAM '/' subjects{i} '/ClusterInputs/'];
    ClusterOutputDir = ['Outputs/' mode_AAM '/' subjects{i} '/ClusterOutputs/'];
    
    mkdir(ClusterInputDir);
    mkdir(ClusterOutputDir);

    iterations = ceil(size(AAMMatUpsampled{i},1)/ClusterInputSize); %No. of times to run
     
    for j = 1:iterations
        [i j]
        if strcmp(mode_AAM,'AAM_all')
            ClusterInput = AAMMatUpsampled{i}(count+1:min(count+ClusterInputSize,size(AAMMatUpsampled{i},1)),:);
        else
            ClusterInput = 0.5 * ( AAMMatUpsampled{i}(count+1:min(count+ClusterInputSize,size(AAMMatUpsampled{i},1)),[5,21,27,43]) + ...
                AAMMatUpsampled{i}(count+1:min(count+ClusterInputSize,size(AAMMatUpsampled{i},1)),[17,12,39,34]) );              
        end
        dlmwrite([ClusterInputDir num2str(j) '.txt'], ClusterInput, ' ');
        system(['python Cluster.py ' ClusterInputDir '/' num2str(j) '.txt ' num2str(Clusters) ' ' ClusterOutputDir '/' num2str(j) '.txt']);
        count = count + ClusterInputSize;
    end
end