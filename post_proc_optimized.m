%Optimized for storage and computation of DCT

clc,clear all,close all
tic
exec_range = [1];
c_flag = 1;

dct_pts = (c_flag + 1)*22;

source_folder_prefix = ['../AAM_Output/Rec'];
count0 = 0;
count1 = 0;
interval = 10;
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

            frame_name = [sentence_name '/' out_file_list(k).name];
            temp_coords = load(frame_name);
            if c_flag == 1
                to_append = [temp_coords.fitted_shape(:,1)' temp_coords.fitted_shape(:,2)'];
            else 
                to_append = temp_coords.fitted_shape(:,1)';
            end
            lip_coordinates_mat(count0,:) = to_append;                 

            if mod(count0,interval) == 0
                count1 = count1 + 1;
                lip_dct_mat(count1,:) = dct(to_append);
            end
        end
    end

%%  DCT : Identification of modes    
    fraction1 = 0.95;
    thresh_choose = [];
    for k = 1:500
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

%%Feature extraction    
lip_width1 = lip_coordinates_mat(:,41)-lip_coordinates_mat(:,37);
lip_width2 = lip_coordinates_mat(:,31)-lip_coordinates_mat(:,23);
lip_width3 = lip_coordinates_mat(:,37)-lip_coordinates_mat(:,15);
lip_width4 = lip_coordinates_mat(:,9)-lip_coordinates_mat(:,19);

lip_height1 = lip_coordinates_mat(:,21)-lip_coordinates_mat(:,17);
lip_height2 = lip_coordinates_mat(:,12)-lip_coordinates_mat(:,5);
lip_height3 = lip_coordinates_mat(:,17)-lip_coordinates_mat(:,5);
lip_height4 = lip_coordinates_mat(:,12)-lip_coordinates_mat(:,21);

d2_vec = lip_coordinates_mat(:,24)-lip_coordinates_mat(:,23);
d1_vec = lip_coordinates_mat(:,27)-lip_coordinates_mat(:,24);

figure(22);
plot(d1_vec);hold on;
plot(d2_vec,'k');



% figure(20);
% subplot(411),plot(lip_width1),title('Lip Width 1');
% subplot(412),plot(lip_width2),title('Lip Width 2');
% subplot(413),plot(lip_width3),title('Lip Width 3');
% subplot(414),plot(lip_width4),title('Lip Width 4');

% figure(21);
% subplot(411),plot(lip_height1),title('Lip Height 1');
% subplot(412),plot(lip_height2),title('Lip Height 2');
% subplot(413),plot(lip_height3),title('Lip Height 3');
% subplot(414),plot(lip_height4),title('Lip Height 4');

end
toc