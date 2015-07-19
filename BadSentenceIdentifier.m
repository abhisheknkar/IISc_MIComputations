% This code identifies all the sentences having too many consecutive
% missing frames

% clc;clear all; close all;
tic
% load('Outputs/AAM_all/AAMs.mat');

threshold = 3;
BadSentences = {[],[],[],[]};
GoodSentences = {[],[],[],[]};

for i = 1:4 %All subjects
    count = 0;
    for j = 1:length(AAMSizeMat{i}) %All sentences
        currmat = AAMMat{i}(count+1:count+AAMSizeMat{i}(j),:);
        count = count + AAMSizeMat{i}(j);

%         Skim through the vector looking for too many zero rows
        zerosfound = 0;
        for k = 1:size(currmat,1)   %All frames
            if(currmat(k,:) == zeros(1,44)) 
                zerosfound = zerosfound + 1;
                if (zerosfound > threshold)
                    BadSentences{i}(end+1) = j;
                    break;
                end
            else 
                zerosfound = 0;
            end
        end
    end
    GoodSentences{i} = setdiff(1:2368, BadSentences{i});    
end
save('Outputs/GoodSentences.mat', 'GoodSentences');
toc