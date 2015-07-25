function generateASRinput_temp(subjectid, fold, featureid)
    % subjectid: 1=Abhay, 2=Abhishek, 3=Gopika, 4=Niranjana    

    % fold: Leaves out all sentences belonging to that fold and uses them as
    % test

    % featureid: Ranges from 1 to 29, description given in the cell "features"
    % below
    % ***In lines 95 and 124, add "features{featureid} '/' " after FEATURES/
    % and before mode to store each feature in a different folder***
    
    tic
    %% Approach
    % Given the inputs, the code should make two folders - a train and a test.
    % The train should contain everything except the input fold. The test
    % should be fold. In each folder, we need to generate:
    % 1. The .mlf file: A concatenation of all the phones in frames in that sentence
    % 2. The .mfc file: A concatenation of all the mfcc files features in that
    % sentence

    %% Domain of input
    subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
    load('Outputs/GoodSentences.mat');
    folds = [9,11,7,14];
    features = {
        'MFCC'
        'AAM_all'
        'AAM_allandMFCC'
        'AAM_lipsonly'
        'AAM_lipsonlyandMFCC'
        'SII_all_SII_TIMITBN_msak0'
        'SII_allandMFCC_SII_TIMITBN_msak0'
        'SII_lipsonly_SII_TIMITBN_msak0'
        'SII_lipsonlyandMFCC_SII_TIMITBN_msak0'
        'SII_all_SII_TIMITBN_fsew0'
        'SII_allandMFCC_SII_TIMITBN_fsew0'
        'SII_lipsonly_SII_TIMITBN_fsew0'
        'SII_lipsonlyandMFCC_SII_TIMITBN_fsew0'
        'SII_all_SII_GASBN_msak0'
        'SII_allandMFCC_SII_GASBN_msak0'
        'SII_lipsonly_SII_GASBN_msak0'
        'SII_lipsonlyandMFCC_SII_GASBN_msak0'
        'SII_all_SII_GASBN_fsew0'
        'SII_allandMFCC_SII_GASBN_fsew0'
        'SII_lipsonly_SII_GASBN_fsew0'
        'SII_lipsonlyandMFCC_SII_GASBN_fsew0'
        'SII_all_SII_TIMIT_msak0'
        'SII_allandMFCC_SII_TIMIT_msak0'
        'SII_lipsonly_SII_TIMIT_msak0'
        'SII_lipsonlyandMFCC_SII_TIMIT_msak0'
        'SII_all_SII_TIMIT_fsew0'
        'SII_allandMFCC_SII_TIMIT_fsew0'
        'SII_lipsonly_SII_TIMIT_fsew0'
        'SII_lipsonlyandMFCC_SII_TIMIT_fsew0'
        'Phonemes'};

    %% Implementation

%     Get the sentences in the required fold using GoodSentences
    perfold = 150;
    foldstart = (fold-1)*perfold+1;
    foldend = min(fold*perfold,length(GoodSentences{subjectid}));
    testsentenceids = GoodSentences{subjectid}(foldstart:foldend);
    trainsentenceids = setdiff(GoodSentences{subjectid}, testsentenceids);

%     Create the folders
    dirnameTrain = ['Outputs/ASR_input/' subjects{subjectid} '/' features{featureid} '/fold' num2str(fold) '/train']; 
    dirnameTest = ['Outputs/ASR_input/' subjects{subjectid} '/' features{featureid} '/fold' num2str(fold) '/test']; 
    mkdir(dirnameTrain); mkdir(dirnameTest);    
    
%     MLF Paths
    mlf_train_path = ['Outputs/ASR_input/' subjects{subjectid} '/' features{featureid} '/fold' num2str(fold) '/train_mlf'];
    mlf_test_path = ['Outputs/ASR_input/' subjects{subjectid} '/' features{featureid} '/fold' num2str(fold) '/test_mlf'];
    
    mfc_train_paths = ['Outputs/ASR_input/' subjects{subjectid} '/' features{featureid} '/fold' num2str(fold) '/train_mfc'];
    mfc_test_paths = ['Outputs/ASR_input/' subjects{subjectid} '/' features{featureid} '/fold' num2str(fold) '/test_mfc'];

    errorlog_train = ['Outputs/ASR_input/' subjects{subjectid} '/' features{featureid} '/fold' num2str(fold) '/errorlog_train.txt'];
    errorlog_test = ['Outputs/ASR_input/' subjects{subjectid} '/' features{featureid} '/fold' num2str(fold) '/errorlog_test.txt'];

    delete(errorlog_train); delete(errorlog_test);
    delete(mlf_train_path); delete(mlf_test_path);
    delete(mfc_train_paths); delete(mfc_test_paths);
    fid2 = fopen(mfc_train_paths, 'w'); fid3 = fopen(mfc_test_paths, 'w');

%     Create the .mfc file
%     Go to each sentence in the fold take each of their required features,
%     write using writehtk

%     Train:
    disp(['Writing feature ' features{featureid} ' in fold ' num2str(fold) ' for ' subjects{subjectid} '.']);
    disp('Writing files for train...');

    mode = 'train';
    mlf_common_path = ['/home/prasanta/HTK_Projects/AV_ASR/FEATURES/' mode '/'];
    for i = 1:length(trainsentenceids)       
        try
            if mod(i,100) == 0
                disp(['Finished ' num2str(i) ' out of ' num2str(length(trainsentenceids)) ' sentences in train.']);
            end
            currid = trainsentenceids(i);
    %         Get the required features
            structpath = ['Outputs/mats_final/' subjects{subjectid} '/' num2str(currid) '.mat'];

            load(structpath);
            featuremat = finalstruct.(features{featureid});
            mfcpath = [dirnameTrain '/' num2str(currid) '.mfc'];
            if size(featuremat,1) == 0
                disp(num2str(currid));
                continue
            end
%             writehtk(mfcpath, featuremat, 0.01, 9);
%             PhonemeToMLF(mlf_train_path, currid, finalstruct.Phonemes, 0.01, i==1, mode);
%             fprintf(fid2, [mlf_common_path num2str(currid) '.mfc\n']);
        catch
            fid1 = fopen(errorlog_train, 'a+');
            fprintf(fid1, ['Error in sentence ' num2str(trainsentenceids(i)) '\n']);
            fclose(fid1);
            disp(['(!)Error in sentence ' num2str(trainsentenceids(i)) '. Deleting it']);
            delete(mfcpath);
        end         
    end
    disp('Finished train. Writing files for test...');

%     Test:

    mode = 'test';
    mlf_common_path = ['/home/prasanta/HTK_Projects/AV_ASR/FEATURES/' mode '/'];
    for i = 1:length(testsentenceids)
        try
            currid = testsentenceids(i);
    %         Get the required features
            structpath = ['Outputs/mats_final/' subjects{subjectid} '/' num2str(currid) '.mat'];

            load(structpath);
            featuremat = finalstruct.(features{featureid});
            mfcpath = [dirnameTest '/' num2str(currid) '.mfc'];
            if size(featuremat,1) == 0
                disp(num2str(currid));
                continue
            end
%             writehtk(mfcpath, featuremat, 0.01, 9);        
%             PhonemeToMLF(mlf_test_path, currid, finalstruct.Phonemes, 0.01, i==1, mode);
%             fprintf(fid3, [mlf_common_path num2str(currid) '.mfc\n']);
        catch
            fid1 = fopen(errorlog_train, 'a+');
            fprintf(fid1, ['Error in sentence ' num2str(testsentenceids(i)) '\n']);
            fclose(fid1);
            disp(['(!)Error in sentence ' num2str(testsentenceids(i)) '. Deleting it']);
            delete(mfcpath);
        end         
    end
    disp(['Finished test.']);
    disp(['Completed feature ' features{featureid} ' in fold ' num2str(fold) ' for ' subjects{subjectid} '.']);
    
    fclose(fid2);
    fclose(fid3);
%     Writing mlf file
%     phonemeTomlf
    
    toc
end    
