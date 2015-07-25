% This code considers the clustering of AAM experiments with just the lip
% features extracted from AAM
clc;clear all; close all;
tic
subjectstorun = 1:4;

methodsToImplement = {...
%     'AAM',...
%     'MFCC',...
%     'Phonemes',...
%     'SII'...
    };
%% MFCC
if ismember('MFCC', methodsToImplement)    
    inputfolder = ['Outputs/MFCC'];
    outputfolder = ['MI'];
    
    disp([inputfolder ' for ']);
    ClusteringFunction(inputfolder, subjectstorun, 0);
    disp('MI for ');
    MIFunction(inputfolder, outputfolder, 'MFCC', subjectstorun);
end
%% AAM
if ismember('AAM', methodsToImplement)    
    modes_AAM = {'AAM_all', 'AAM_lipsonly'}; 
    additionals_AAM = {'', 'andMFCC'};
    for i = 1:2 %Modes
        mode_AAM = modes_AAM{i};
        for j = 1:2 %Additionals            
            additional_AAM = additionals_AAM{j};
            inputfolder = ['Outputs/AAM/' mode_AAM additional_AAM];
            outputfolder = ['MI/AAM'];
            if j == 1 
                tonormalize = 0;
            else 
                tonormalize = 1;
            end
            disp([inputfolder ' for ']);
            ClusteringFunction(inputfolder, subjectstorun, tonormalize);
            disp('MI for ');
            MIFunction(inputfolder, outputfolder, [mode_AAM additional_AAM], subjectstorun);
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

                        inputfolder = ['Outputs/' mode '/' trainwith '/' [scheme additional]];
                        outputfolder = ['MI/' mode '/' trainwith];
                        if p == 1 
                            tonormalize = 0;
                        else 
                            tonormalize = 1;
                        end
                        disp([inputfolder ' for ']);
                        ClusteringFunction(inputfolder, subjectstorun, tonormalize);
                        disp('MI for ');
                        MIFunction(inputfolder, outputfolder, [scheme additional], subjectstorun);
                   end
                end
            end
        end
    end
end
toc