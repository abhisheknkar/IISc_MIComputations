clc;clear all; close all;

%% 
% AAM
% execRange = [4];
% AAM_Clustering_Code1;AAM_Clustering_Code2;MI_Phoneme_AAM_Code;
% 
% %%
% % AAM and MFCC
% execRange = [2:4];
% AAMandMFCC_Clustering_Code;MI_Phoneme_AAMandMFCC_Code;
% %%
execRange = [2];
schemes = {'SII_TIMITBN', 'SII_GASBN', 'SII_TIMIT'};
trainwiths = {'msak0', 'fsew0'};
mode = 'SII_all';

nRange = 2;

% % SII alone, all features
% for m = execRange
%     for n = nRange
%         scheme = schemes{m};
%         trainwith = trainwiths{n};
%         SII_Clustering_Code1;SII_Clustering_Code2; MI_Phoneme_SII_Code;
%     end
% end

%%
% SII only lips
% execRange = [2];
% mode = 'SII_lipsonly';
% for m = execRange
%     for n = nRange
%         scheme = schemes{m};
%         trainwith = trainwiths{n};
%         SII_Clustering_Code1;SII_Clustering_Code2; MI_Phoneme_SII_Code;
%     end
% end

%%
% SII+MFCC all
execRange = [2];
mode = 'SII_all';
for m = execRange
    for n = nRange
        scheme = [schemes{m} 'andMFCC'];
        trainwith = trainwiths{n};
        SII_MFCC_Clustering_Code;
        MI_Phoneme_SII_MFCC_Code;
    end
end

%%
% SII+MFCC only lips
execRange = [2];
mode = 'SII_lipsonly';
for m = execRange
    for n = nRange
        scheme = [schemes{m} 'andMFCC'];
        trainwith = trainwiths{n};
        SII_MFCC_Clustering_Code;
        MI_Phoneme_SII_MFCC_Code;
    end
end