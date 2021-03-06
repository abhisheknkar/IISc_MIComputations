clc;clear all;close all;
% This file initializes all the final mats and distributes the outputs
% among them appropriately
tic

%% MFCC
finalstruct.MFCC = [];

%% AAM fields
modes_AAM = {'AAM_all', 'AAM_lipsonly'}; 
additionals_AAM = {'', 'andMFCC'};
for i = 1:2 %Modes
    mode_AAM = modes_AAM{i};
    for j = 1:2 %Additionals            
        additional_AAM = additionals_AAM{j};
        fieldname = [mode_AAM additional_AAM];
        finalstruct.(fieldname) = [];
    end
end

%% SII variants
schemes = {'SII_TIMITBN', 'SII_GASBN', 'SII_TIMIT'};
trainwiths = {'msak0', 'fsew0'};
modes = {'SII_all', 'SII_lipsonly'};
additionals = {'', 'andMFCC'};
execRange = 1:3;
nRange = 1:2; %For the trainwith

for m = 1:3 %Scheme
    scheme = schemes{m};
    for n = 1:2 %Trainwith
        trainwith = trainwiths{n};
        for o = 1:2   %Mode
            mode = modes{o};
            for p = 1:2   %Additional
                additional = additionals{p};
                fieldname = [mode additional '_' scheme '_' trainwith];
                finalstruct.(fieldname) = [];
            end
        end
    end
end
    
%% Phoneme
finalstruct.Phonemes = [];

%% Store them
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
load('Outputs/GoodSentences.mat');
for l = 1:4
    disp(['Saving outputs for ' subjects{l}]);
    mkdir(['Outputs/mats_final/' subjects{l}]);
    for k = 1:length(GoodSentences{l})
        outputfilename = ['Outputs/mats_final/' subjects{l} '/' num2str(GoodSentences{l}(k)) '.mat'];
        save(outputfilename, 'finalstruct');    
    end
end
toc