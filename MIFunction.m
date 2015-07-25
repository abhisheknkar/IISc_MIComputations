function MIFunction(inputfolder, outputfolder, mode, subjectstorun)
    subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
    % Read cluster files for all batches for all subjects
    MIMat = {[],[],[],[]};

    if exist([outputfolder '/' mode '_Phoneme.mat'])
        load([outputfolder '/' mode '_Phoneme.mat']);
    end

    for i = subjectstorun
        disp(subjects{i});
        MIMat{i} = [];
        PhonemeClusterPath = ['Outputs/Phonemes/' subjects{i} '/ClusterOutputs/'];
        ModeClusterPath = [inputfolder '/' subjects{i} '/ClusterOutputs/'];

        PhonemeFiles = dir([PhonemeClusterPath '*.txt']);
        ModeFiles = dir([ModeClusterPath '*.txt']);

        for j = 1:length(ModeFiles)
            PhonemeCluster = dlmread([PhonemeClusterPath ModeFiles(j).name], '\n');
            ModeCluster = dlmread([ModeClusterPath ModeFiles(j).name], '\n'); 
            MIMat{i}(j) = computeMI(PhonemeCluster, ModeCluster);        
        end
    end
    mkdir(outputfolder);
    save([outputfolder '/' mode '_Phoneme.mat'], 'MIMat');
end