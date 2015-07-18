% This code creates reads all the mfcc files of all subjects and dumps them into a cell
% clc;clear all;close all;
tic
addpath('voicebox/');
% scheme = 'SII_TIMITBN';
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
SIIMat = {[],[],[],[]};
SIISizeMat = {[],[],[],[]};

for i = subjectstorun
    for j = 1:24
        j
        folder_path = ['../SII_' trainwith '/' scheme '/' subjects{i} '/SII_Outputs/Rec' num2str(j) '/']; 
        for k = 1:100
            filename = [folder_path num2str((j-1)*100+k) '_arti.mat'];
            if exist(filename)
                clear('yhat');
                load(filename);
                
                if strcmp(mode, 'SII_all') == 1
                    readOutput = yhat(:,[1:7,9:15]);
                else
                    readOutput = yhat(:,[1,2,9,10]);
                end
                SIIMat{i}(end+1:end+size(readOutput,1),:) = readOutput;
                SIISizeMat{i}((j-1)*100+k) = size(readOutput,1);
            else
                SIISizeMat{i}((j-1)*100+k) = 0;
            end
        end
    end
    dirToSave = ['Outputs/' mode '/' trainwith '/' scheme '/'];
    mkdir(dirToSave);
    save([dirToSave 'SII_Outputs.mat'], 'SIIMat', 'SIISizeMat');
end
toc