% This code considers the clustering of AAM experiments with just the lip
% features extracted from AAM
clc;clear all; close all;
subjectstorun = [3];
% %% 
% % AAM all coordinates
% mode_AAM = 'AAM_all';
% AAM_Clustering_Code1;AAM_Clustering_Code2;MI_Phoneme_AAM_Code;
% 
% % AAM all and MFCC
% mode_AAM = 'AAM_all';
% AAMandMFCC_Clustering_Code;MI_Phoneme_AAMandMFCC_Code;

% AAM lips only
% mode_AAM = 'AAM_lipsonly';
% AAM_Clustering_Code2;MI_Phoneme_AAM_Code;

% AAM lips only and MFCC
% mode_AAM = 'AAM_lipsonly';
% AAMandMFCC_Clustering_Code;
% MI_Phoneme_AAMandMFCC_Code;

%%

execRange = [1];
schemes = {'SII_TIMITBN', 'SII_GASBN', 'SII_TIMIT'};
trainwiths = {'msak0', 'fsew0'};
mode = 'SII_all';
% 
nRange = 2; %For the trainwith
% 
% % SII alone, all features
for m = execRange
    for n = nRange
        scheme = schemes{m};
        trainwith = trainwiths{n};
        SII_Clustering_Code1;
%         SII_Clustering_Code2; MI_Phoneme_SII_Code;
    end
end
% 
% %
% % SII only lips
% % execRange = [3];
% mode = 'SII_lipsonly';
% for m = execRange
%     for n = nRange
%         scheme = schemes{m};
%         trainwith = trainwiths{n};
% %         SII_Clustering_Code1;SII_Clustering_Code2; 
%         MI_Phoneme_SII_Code;
%     end
% end
% 
% %%
% % SII+MFCC all
% % execRange = [2];
% mode = 'SII_all';
% for m = execRange
%     for n = nRange
%         scheme = [schemes{m} 'andMFCC'];
%         trainwith = trainwiths{n};
% %         SII_MFCC_Clustering_Code;
%         MI_Phoneme_SII_MFCC_Code;
%     end
% end
% 
% %%
% % SII+MFCC only lips
% % execRange = [2];
% mode = 'SII_lipsonly';
% for m = execRange
%     for n = nRange
%         scheme = [schemes{m} 'andMFCC'];
%         trainwith = trainwiths{n};
%         SII_MFCC_Clustering_Code;
%         MI_Phoneme_SII_MFCC_Code;
%     end
% end