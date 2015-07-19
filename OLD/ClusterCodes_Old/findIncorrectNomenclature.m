% Find all the sentences for which zero frames occur in AAMMat. 

clc;clear all; close all;
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};

scheme = 'AAM';

dirToSave = ['Outputs/' scheme '/'];
mkdir(dirToSave);
load([dirToSave 'AAMs.mat']);
load([dirToSave 'AAMUpsampled.mat']);
disp('AAMs loaded!');
execRange = [3];

for i = execRange
    last = 0;
    fid = fopen([dirToSave 'tobeCorrected/' subjects{i} '_tobecorrected.txt'],'a');
    for j = 1:2368 %All sentences
        total = sum(sum(AAMMat{i}(last+1:last+AAMSizeMat{i}(j),:)));
        if total == 0
            fprintf(fid,[num2str(j) '\n']);
        end
    end
    fclose(fid);   
end
