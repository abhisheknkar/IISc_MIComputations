clc;clear all;close all;

SUBJ_list = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
ToDoRecs = {[],[],[20:24],[]};
curr_dir = pwd;

for p = 1:length(SUBJ_list)
    SUBJ = SUBJ_list{p}
    exec_range = ToDoRecs{p};
    for i = exec_range
        i
        RecDir = ['../../X/' SUBJ '/AAM/Rec' num2str(i) '/'];
        SentenceList = dir([RecDir '/s*']);
        for j = 1:length(SentenceList)
            SentenceNumberRel = mod(str2num(SentenceList(j).name(2:end)),100);
            if SentenceNumberRel == 0
                SentenceNumberRel = 100;
            end
            SentenceNumberAbs = (i-1)*100 + SentenceNumberRel;
%             SentenceNumberAbs = SentenceNumberRel;            
            CurrName =[RecDir SentenceList(j).name];
            NewName =[RecDir 's' num2str(SentenceNumberAbs)];
            unix(['mv ' CurrName ' ' NewName]);   
%             pause;
        end
    end
end