tic
Phonemes = {'aa','ae','aw','ax','ay','b','ch','d','dh','dx','eh','er','ey'...
    ,'f','g','hh','ix','iy','jh','k','l','m','n','ng','ow','oy','p','r',...
    's','sh','SIL','t','th','uh','ux','v','w','y','z'};
% load('Outputs/SII_TIMITBN/MFCCs.mat');
clear PhonemeMat
subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};

PhonemeMap = containers.Map;
for i = 1:length(Phonemes)
    PhonemeMap(Phonemes{i})=i;
end

PhonemeMat = {[],[],[],[]};
PhonemeSizeMat = {[0],[0],[0],[0]};
MFCCSizeCumMat = {[],[],[],[]};

for i = 1:4
    i
%     Read the phoneme file
    MFCCSizeCumMat{i} = cumsum(MFCCSizeMat{i}); 
    
    count_curr = 0;
    for j = 1:24
        fid = fopen(['codes_align_correction/Output/' subjects{i} '/Step6_Output/' num2str(j) '_align_corrected.out']);        
        
        while ~feof(fid)  
            thisline = fgetl(fid);
            if thisline(1) == '.' || thisline(1) == '#'
                continue            
            elseif thisline(1) == '"'
                aa = find(thisline == '/'); aa = aa(end);
                bb = find(thisline == '.'); bb = bb(end);
                file_num = str2num(thisline(aa+1:bb-1));
%                 file_num              
                count_prev = count_curr;
                count_curr = length(PhonemeMat{i});   %Has to be done when new file is encountered
                
                PhonemeSizeMat{i}(max(file_num-1,1))=count_curr-count_prev;                 
                
            else
                split_string = regexp(thisline, ' ', 'split');
                % Rescale according to sampling frequency
                split_string{1} = floor(str2num(split_string{1})/10^5);
                split_string{2} = floor(str2num(split_string{2})/10^5);
                

                if strcmp(split_string{3},'SIL') == 1 && split_string{1} ~= 0   %The last phoneme
%                     PhonemeMat{i}(end+1 : count_curr+MFCCSizeMat{i}(file_num)) = PhonemeMap(split_string{3});
                    PhonemeMat{i}(end+1 : MFCCSizeCumMat{i}(file_num)) = PhonemeMap(split_string{3});
                else
                    PhonemeMat{i}(end+1 : count_curr+split_string{2}) = PhonemeMap(split_string{3});
                end
            end
        end
        
        fclose(fid);
    end
    PhonemeSizeMat{i}(end+1) = count_curr - count_prev;
    save('Outputs/Phonemes/PhonemeMat.mat', 'PhonemeMat', 'PhonemeSizeMat');
end
toc