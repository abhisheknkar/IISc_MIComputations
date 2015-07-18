clc;clear all; close all;

modes = {'SII_all', 'SII_lipsonly'};    %i
additional_features = {'', 'andMFCC'};  %j
schemes = {'SII_TIMITBN', 'SII_GASBN', 'SII_TIMIT'};    %k
trainwiths = {'msak0', 'fsew0'};    %l

count = 0;
results_SII = cell(2,2,3,2);

mode = 'SII_all';
for i = 1:2
    mode = modes{i};
    for j = 1:2
        additional_feature = additional_features{j};
        for k = 1:3
            scheme = schemes{k};
            for l = 1:2
                trainwith = trainwiths{l}; 
                filename = ['MI/' mode '/' trainwith '/' scheme additional_feature '_Phoneme.mat'];
                if exist(filename)                    
                    clear MIMat
                    load(filename);
                    results_SII{i,j,k,l} = MIMat;
                end
            end
        end
    end
end

results_AAM = cell(5,1);
schemes_AAM = {'AAM_all', 'AAM_all_MFCC', 'AAM_lipsonly', 'AAM_lipsonly_MFCC', 'MFCC'};
for m = 1:5
    filename = ['MI/' schemes_AAM{m} '_Phoneme.mat'];
    if exist(filename)  
        clear MIMat
        load(filename);
        results_AAM{m} = MIMat;
    end
end

tables = zeros(3,2,4);
filename = 'MI/tables.txt';
% Get partial results
for i = 1:2
    for j = 1:2
        for k = 1:3
            for l = 1:2
                [i,j,k,l]
                if size(results_SII{i,j,k,l}) > 0
                    if size(results_SII{i,j,k,l}{1}) > 0
                        tables(k,l,2*(i-1)+j) = results_SII{i,j,k,l}{1}(1);      
                    end
                end
            end
        end
    end
end

tableids = {'All, single', 'All, MFCC', 'LipsOnly, single', 'LipsOnly, MFCC'};
fid = fopen(filename,'w');
for i = 1:5
    fprintf(fid, [schemes_AAM{i} ': ']);
    fprintf(fid, [num2str(results_AAM{i}{1}(1)) '\n']);
end

fprintf(fid, 'Table format:\n\tTIMITBN\tGASBN\tTIMIT\nMSAK0\nFSEW0'); 

for i = 1:4
    fprintf(fid, ['\n' tableids{i} '\n']);
%     fprintf(fid,'%6.2f %12.8f\n',A);
    fprintf(fid,'%6.2f %6.2f %6.2f\n',tables(:,:,i));
%     dlmwrite(filename,tables(:,:,i), 'delimiter','\t','precision',3, '-append');
end

fclose(fid);