Clusters = 256;
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};

for i = subjectstorun
    disp(subjects{i});
    ClusterInputDir = ['Outputs/' mode_AAM '/' subjects{i} '/ClusterInputs/'];
    ClusterOutputDir = ['Outputs/' mode_AAM '/' subjects{i} '/ClusterOutputs/'];
    mkdir(ClusterOutputDir);

    iterations = size(dir([ClusterInputDir '*.txt']),1);
     
    for j = 1:iterations        
        system(['python Cluster.py ' ClusterInputDir '/' num2str(j) '.txt ' num2str(Clusters) ' ' ClusterOutputDir '/' num2str(j) '.txt']);
    end
end