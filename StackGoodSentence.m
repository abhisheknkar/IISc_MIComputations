% This script stacks good sentences in groups of 150 for AAM + MFCC +
% Phonemes + SII (12)  + SIIandMFCC (12) and stores as cluster inputs
clc;clear all;close all;
tic
methodsToImplement = {...
%     'AAM',...
%     'MFCC',...
%     'Phonemes',...
%     'SII'...
    };

foldsize = 150;
load('Outputs/GoodSentences.mat');
%%
%AAM
if ismember('AAM', methodsToImplement)    
    modes_AAM = {'AAM_all', 'AAM_lipsonly'}; 
    additionals_AAM = {'', 'andMFCC'};
    
    disp('Loading AAMs');load('Outputs/AAM/AAM_all/AAMUpsampled1to1.mat');
    disp('Loading MFCCs');load('Outputs/MFCC/MFCCs.mat');
    disp('AAMs loaded. Folding them...');

    for i = 1:2 %Modes
        mode_AAM = modes_AAM{i};
        for j = 1:2 %Additionals            
            additional_AAM = additionals_AAM{j};
            disp(['Current iteration is on: ' mode_AAM ', ' additional_AAM]);  
            toPass = AAMMatUpsampled1to1;
            
            if i == 2
                for k = 1:4
                    toPass{k} = 0.5 * (toPass{k}(:,[5,21,27,43]) + toPass{k}(:,[17,12,39,34]));
                end
            end
            
            if j == 2
               for k = 1:4
                   toPass{k} = [toPass{k} MFCCMat{k}];
               end
            end
            outputfolder = ['Outputs/AAM/' mode_AAM additional_AAM]; 
            coreStacker(toPass, MFCCSizeMat, outputfolder, foldsize);
        end
    end
end
%%
%MFCC
if ismember('MFCC', methodsToImplement)
    disp('Loading MFCCs');load('Outputs/MFCC/MFCCs.mat');
    disp('MFCCs loaded. Folding them...');
    coreStacker(MFCCMat, MFCCSizeMat, 'Outputs/MFCC', foldsize);
end
%%
%Phonemes
if ismember('Phonemes', methodsToImplement)
    disp('Loading Phonemes');load('Outputs/Phonemes/PhonemeMat.mat');
    disp('Phonemes loaded. Folding them...');
    coreStacker(PhonemeMat, PhonemeSizeMat, 'Outputs/Phonemes', foldsize);
end

%%
%SII variants
if ismember('SII', methodsToImplement)
    schemes = {'SII_TIMITBN', 'SII_GASBN', 'SII_TIMIT'};
    trainwiths = {'msak0', 'fsew0'};
    modes = {'SII_all', 'SII_lipsonly'};
    additionals = {'', 'andMFCC'};
    execRange = 1:3;
    nRange = 1:2; %For the trainwith

    if ismember('SII', methodsToImplement)
        for m = 1:3 %Scheme
            scheme = schemes{m};
            for n = 1:2 %Trainwith
                trainwith = trainwiths{n};
                for o = 1:2   %Mode
                    mode = modes{o};
                    for p = 1:2   %Additional
                        additional = additionals{p};
                        [m n o p]
                        disp(['Loading ' mode '/' trainwith '/' scheme]);load(['Outputs/' mode '/' trainwith '/' scheme '/SII_Outputs.mat']);

                        disp('Loading MFCCs');load('Outputs/MFCC/MFCCs.mat');
                        disp('MFCCs loaded.');
                        disp('SII outputs loaded. Folding them...');
                        coreStacker_SII(SIIMat, MFCCMat, SIISizeMat, scheme, trainwith, mode, additional, foldsize);
                    end
                end
            end
        end
    end
end
toc