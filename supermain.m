clc;clear all; close all;

%% 
% AAM
execRange = [4];
AAM_Clustering_Code1;AAM_Clustering_Code2;MI_Phoneme_AAM_Code;

%%
% AAM and MFCC
execRange = [1:3];

%%
% SII alone, all features
execRange = [2:3];
schemes = {'SII_TIMITBN', 'SII_GASBN', 'SII_TIMIT'};
trainwiths = {'msak0', 'fsew0'};
mode = 'SII_all';

for i = execRange
    for j = 1
        scheme = schemes{i};
        trainwith = trainwiths{j};
        SII_Clustering_Code1;SII_Clustering_Code2; MI_Phoneme_SII_Code;
    end
end

%%
% SII only lips
execRange = [2:3];
mode = 'SII_lipsonly';
for i = execRange
    for j = 1
        scheme = schemes{i};
        trainwith = trainwiths{j};
        SII_Clustering_Code1;SII_Clustering_Code2; MI_Phoneme_SII_Code;
    end
end

%%
% SII+MFCC all
execRange = [2:3];
mode = 'SII_all';
for i = execRange
    for j = 1
        scheme = schemes{i};
        trainwith = trainwiths{j};
        SII_Clustering_Code1;SII_Clustering_Code2; MI_Phoneme_SII_Code;
    end
end

%%
% SII+MFCC only lips
execRange = [1:3];
mode = 'SII_lipsonly';
for i = execRange
    for j = 1
        scheme = schemes{i};
        trainwith = trainwiths{j};
        SII_Clustering_Code1;SII_Clustering_Code2; MI_Phoneme_SII_Code;
    end
end
