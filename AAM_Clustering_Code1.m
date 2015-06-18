clc;clear all;close all;
tic
c_flag = 1;
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};

scheme = 'AAM';

AAMMat = {[],[],[],[]};
AAMMatUpsampled = {[],[],[],[]};
AAMSizeMat = {[],[],[],[]};

dirToSave = ['Outputs/' scheme '/'];
mkdir(dirToSave);
% load([dirToSave 'AAMs.mat']);

%  Populating the lip coordinate matrix for each frame
for i = [1]
% Recording Level
    for j = 1%:24  %All recordings
        [i,j]
        rec_folder = ['../../X/' subjects{i} '/AAM/Rec' num2str(j) '/'];
        label_file = ['Labels/' subjects{i} '/' num2str((j-1)*100+1) '_' num2str(min(100*j,2368)) 'l.txt'];
        fid = fopen(label_file);
        meas = fscanf(fid, '%f', [3, Inf]);
 % Sentence level 
        for k = 1:size(meas,2)   %All sentences
            sentence_number = meas(3,k);
            if exist([rec_folder 's' num2str(sentence_number)],'dir')
                start_frame = round(meas(1,k) *25);
                stop_frame = round(meas(2,k) *25);
                total_frames = stop_frame - start_frame;
                
                AAMSizeMat{i}(end+1) = total_frames;
                
                % Get frames
                sentence_folder = [rec_folder '/s' num2str(sentence_number)];
                
 % Frame Level
                for m = 1:total_frames
                    frame_path = [sentence_folder '/out' num2str(sentence_number) '_' num2str(m) '.jpg.mat'];
                    if exist(frame_path,'file') 
                        CoordMat = load(frame_path);
                        AAMCoords = CoordMat.fitted_shape; 
                        ToAdd = [AAMCoords(:,1)' AAMCoords(:,2)'];
                        AAMMat{i}(end+1,:) = ToAdd;  
                    else
                        AAMMat{i}(end+1,:) = zeros(1,44);
                    end
                end
            end
        end
    end
    for n = 1:44
        AAMMatUpsampled{i}(:,n) = interp(AAMMat{i}(:,n),4);
    end
end

% save([dirToSave 'AAMs.mat'], 'AAMMat', 'AAMSizeMat');
% save([dirToSave 'AAMUpsampled.mat'], 'AAMMatUpsampled');
toc

AAM_Clustering_Code2
computeMI