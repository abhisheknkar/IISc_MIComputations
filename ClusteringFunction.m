function ClusteringFunction( inputfolder, subjectstorun, tonormalize )
%This function performs clustering of single schemes
Clusters = 256;
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};

for i = subjectstorun
    disp(subjects{i});
    ClusterInputDir = [inputfolder '/' subjects{i} '/ClusterInputs'];
    ClusterOutputDir = [inputfolder '/' subjects{i} '/ClusterOutputs'];
    mkdir(ClusterOutputDir);

    iterations = size(dir([ClusterInputDir '/*.txt']),1);
    for j = 1:iterations  
        if tonormalize == 1
            A = dlmread([ClusterInputDir '/' num2str(j) '.txt'], ' ');
            A = normalize_by_col(A);
            dlmwrite([ClusterInputDir '/' num2str(j) '.txt'], A, ' ');
        end
        
        system(['python Cluster.py ' ClusterInputDir '/' num2str(j) '.txt ' num2str(Clusters) ' ' ClusterOutputDir '/' num2str(j) '.txt']);
    end
end
end