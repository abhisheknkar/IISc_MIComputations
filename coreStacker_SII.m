function [] = coreStacker_SII( input_SII, input_MFCC, inputsizemat, scheme, trainwith, mode, additional, foldsize)
%This function extracts the frames corresponding to the good sentences,
%stores them in the location specified

load('Outputs/GoodSentences.mat');
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};

input = input_SII;
inputGood = {[],[],[],[]};
inputGoodsizemat = {[],[],[],[]};

outputfolder = ['Outputs/' mode '/' trainwith '/' [scheme additional]];

for i = 1:4
%     if strcmp(mode, 'SII_lipsonly') == 1
%         input{i} = input{i}(:,[1,2,8,9]);
%     end
    if strcmp(additional, 'andMFCC') == 1
        input{i} = [input{i} input_MFCC{i}];
    end
    
    mkdir([outputfolder '/' subjects{i} '/ClusterInputs/']);
    
    disp(['Folding data for ' subjects{i}]);
    foldcount = 0;
    toStore = [];
    cumulativesizes = cumsum(inputsizemat{i});
    
    folds = 0;
    for j = 1:length(GoodSentences{i})        
        foldcount = foldcount + 1;
        if foldcount > foldsize
%         Store in new file
            folds = folds + 1;
            inputGood{i}(end+1:end+size(toStore,1),1:size(toStore,2)) = toStore;
            dlmwrite([outputfolder '/' subjects{i} '/ClusterInputs/' num2str(folds) '.txt'], toStore, ' ');
            toStore = [];
            foldcount = 0;
        end
%         Append to the output 
        if GoodSentences{i}(j) == 1
            startfrom = 1;
        else
            startfrom = cumulativesizes(GoodSentences{i}(j)-1) + 1;
        end
        endat = cumulativesizes(GoodSentences{i}(j));

        inputGoodsizemat{i}(end+1) = endat - startfrom + 1;
        toStore(end+1:end+inputsizemat{i}(GoodSentences{i}(j)),1:size(input{i},2)) = input{i}(startfrom:endat,1:size(input{i},2));
        
    end
    if size(toStore,1) > 0        
        inputGood{i}(end+1:end+size(toStore,1),1:size(toStore,2)) = toStore;
        dlmwrite([outputfolder '/' subjects{i} '/ClusterInputs/' num2str(folds+1) '.txt'], toStore, ' ');
    end
end
save([outputfolder '/goodmat.mat'], 'inputGood', 'inputGoodsizemat');
end
