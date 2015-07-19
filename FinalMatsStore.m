clc;clear all;close all;
% This file distributes the outputs amongst individual files
% Protocol: Load -> distribute
tic

methodsToImplement = {...
%     'AAM',...
%     'MFCC',...
    'Phonemes',...
%     'SII'...
    };
%% Load good sentences
load('Outputs/GoodSentences.mat');
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};

%% MFCC
if ismember('MFCC', methodsToImplement)    
    clear 'inputGood', 'inputGoodsizemat';
    load('Outputs/MFCC/goodmat.mat');
    disp('MFCC data loaded. Saving MFCC data for');
    coreStorer(inputGood, inputGoodsizemat, 'MFCC');
end

%% AAM fields
modes_AAM = {'AAM_all', 'AAM_lipsonly'}; 
additionals_AAM = {'', 'andMFCC'};

if ismember('AAM', methodsToImplement)    
    for i = 1:2 %Modes
        mode_AAM = modes_AAM{i};
        for j = 1:2 %Additionals            
            additional_AAM = additionals_AAM{j};
            fieldname = [mode_AAM additional_AAM];
            
            filename = ['Outputs/AAM/' mode_AAM additional_AAM '/goodmat.mat']; 
            %Now do it for all files
            clear 'inputGood', 'inputGoodsizemat';
            load(filename);
            disp(['AAM data loaded for config: ' mode_AAM additional_AAM '. Saving MFCC data for']);
            coreStorer(inputGood, inputGoodsizemat, fieldname);
            disp('\n');
        end
    end
end

%% SII variants
if ismember('SII', methodsToImplement)    
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
                    [m n o p]
                    additional = additionals{p};
                    fieldname = [mode additional '_' scheme '_' trainwith];

                    filename = ['Outputs/' mode '/' trainwith '/' [scheme additional] '/goodmat.mat'];
                    %Now do it for all files
                    clear 'inputGood', 'inputGoodsizemat';
                    load(filename);
                    disp(['SII data loaded for config: ' mode '/' trainwith '/' [scheme additional] '. Saving MFCC data for']);
                    coreStorer(inputGood, inputGoodsizemat, fieldname);
                end
            end
        end
    end
end

%% Phoneme
if ismember('Phonemes', methodsToImplement)    
    clear 'inputGood', 'inputGoodsizemat';
    load('Outputs/Phonemes/goodmat.mat');
    disp('Phoneme data loaded. Saving Phoneme data for');
    coreStorer(inputGood, inputGoodsizemat, 'Phonemes');
end
toc