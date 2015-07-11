tic
c_flag = 1;
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};

scheme = 'AAM';

AAMMat = {[],[],[],[]};
AAMMatUpsampled = {[],[],[],[]};
AAMSizeMat = {[],[],[],[]};

dirToSave = ['Outputs/' scheme '/'];
mkdir(dirToSave);
load([dirToSave 'AAMs.mat']);
load([dirToSave 'AAMUpsampled.mat']);
disp('AAMs loaded!');
% execRange = [4];
catchcount = 0;
%  Populating the lip coordinate matrix for each frame
for i = execRange
% Recording Level
    AAMSizeMat{i} = [];
    AAMMatUpsampled{i} = [];
    sumframes = 0;
    temp = [];
    for j = 1:24  %All recordings
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
                
                AAMSizeMat{i}(sentence_number) = total_frames;
                % Get frames
                sentence_folder = [rec_folder '/s' num2str(sentence_number)];
%  Frame Level
                for m = 1:total_frames
                    frame_path = [sentence_folder '/out' num2str(sentence_number) '_' num2str(m) '.jpg.mat'];
                    if exist(frame_path,'file')
                        try
                            CoordMat = load(frame_path);
                            AAMCoords = CoordMat.fitted_shape; 
                            ToAdd = [AAMCoords(:,1)' AAMCoords(:,2)'];
                            temp(end+1,:) = ToAdd;
                        catch
                            catchcount = catchcount + 1;
                            temp(end+1,:) = zeros(1,44);
                        end
                    else
                        temp(end+1,:) = zeros(1,44);
                    end
                end
                sumframes = sumframes + total_frames;
            else
                AAMSizeMat{i}(sentence_number) = 0;
            end
%             sentence_number
       end
    end
    AAMMat{i} = temp;
    for n = 1:44
        AAMMatUpsampled{i}(:,n) = interp(AAMMat{i}(:,n),4);
    end
    save([dirToSave 'AAMs.mat'], 'AAMMat', 'AAMSizeMat');
    save([dirToSave 'AAMUpsampled.mat'], 'AAMMatUpsampled');
end
toc
% disp(['Expected size: ' num2str(sum(AAMSizeMat{1})) '. Total frames: ' num2str(sumframes)]);