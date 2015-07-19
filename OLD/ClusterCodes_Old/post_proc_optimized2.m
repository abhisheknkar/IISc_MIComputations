%Don't need to find dimension beforehand. Check the other code for a better
%way.

clc,clear all,close all
tic
exec_range = [1];
c_flag = 1;

dct_pts = (c_flag + 1)*22;

source_folder_prefix = ['../AAM_Output/Rec'];
count0 = 0;
count1 = 0;
interval = 10;
size_fin = 0;

%%  Finding the size of matrix required
for i = exec_range
    sentence_list = dir([source_folder_prefix num2str(i) '/s*']);
    for j = 1:size(sentence_list,1)
        sentence_name = [source_folder_prefix num2str(i) '/' sentence_list(j).name];
        out_file_list = dir([sentence_name '/*.jpg.mat']);
        size_fin = size_fin + size(out_file_list,1);
    end
end
size_reqd = floor(size_fin);
lip_coordinates_mat = zeros(size_reqd, 44);
lip_dct_mat = zeros(size_reqd, 44);

%%  Populating the lip coordinate and the DCT matrix for each frame
for i = exec_range
    i
    lip_coordinates_mat = [];
    lip_dct_mat = [];
    
    sentence_list = dir([source_folder_prefix num2str(i) '/s*']);

    for j = 1:size(sentence_list,1)
        j
        sentence_name = [source_folder_prefix num2str(i) '/' sentence_list(j).name];
        out_file_list = dir([sentence_name '/*.jpg.mat']);

        for k = 1:size(out_file_list,1)
            count0 = count0 + 1;
            if mod(count0,interval) == 0
                count1 = count1 + 1;
                frame_name = [sentence_name '/' out_file_list(k).name];
                temp_coords = load(frame_name);

                if c_flag == 1
                    to_append = [temp_coords.fitted_shape(:,1)' temp_coords.fitted_shape(:,2)'];
                else 
                    to_append = temp_coords.fitted_shape(:,1)';
                end
                lip_dct_mat(count1,:) = dct(to_append);
                lip_coordinates_mat(count1,:) = to_append;                 
            end
        end
    end

%%  DCT : Identification of modes    
    fraction1 = 0.95;
    thresh_choose = [];
    for k = 1:100
%         figure(102),plot(lip_dct_mat(k,:));pause;
        total_energy_DCT = sum(lip_dct_mat(k,:).^2);
        cumulative_energy_DCT =  cumsum(lip_dct_mat(k,:).^2);
        thresh_DCT = find(cumulative_energy_DCT > fraction1*total_energy_DCT);
        thresh_DCT(1);%,pause;
        thresh_choose = [thresh_choose thresh_DCT(1)];
    end
%     figure(103), plot(thresh_choose);   

%%  PCA on the lip coordinates
    k_pca = 10;
    cov_mat = cov(lip_coordinates_mat);
    [V D] = eigs(cov_mat, k_pca);

    compressed_lip_coordinates_mat = lip_coordinates_mat*V;
end
toc