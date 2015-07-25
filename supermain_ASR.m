clc;clear all; close all;

subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
folds = [9,11,7,14];    %Total folds per subject

for i = 1:4     %Subjects
    for j = 1:folds(i)  %Folds
        for k = 1:29    %Features
            [i j k]
            generateASRinput(i,j,k);
        end
    end
end