function PhonemeToMLF( fout, recid, phonemevalues, Ts , firstflag, mode)
    mlf_common_path = ['"/home/prasanta/HTK_Projects/AV_ASR/FEATURES/' mode '/'];
    mlf_path = [mlf_common_path num2str(recid) '.rec"'];

    Phonemes = {'aa','ae','aw','ax','ay','b','ch','d','dh','dx','eh','er','ey'...
        ,'f','g','hh','ix','iy','jh','k','l','m','n','ng','ow','oy','p','r',...
        's','sh','SIL','t','th','uh','ux','v','w','y','z'};
% Open a file
    fid = fopen(fout, 'a+');
    if firstflag == 1
        fprintf(fid, '#!MLF!#\n');
    end
    fprintf(fid, [mlf_path '\n']);
    phonemestart = 0;
    phonemeend = -1;
    prevphoneme = phonemevalues(1);
    for i = 1:length(phonemevalues)
        currphoneme = phonemevalues(i);
        if ~(prevphoneme == currphoneme)
%             if ~(phonemeend == -1)
                phonemeend = i-1;
                fprintf(fid, [num2str(phonemestart*10^7*Ts) ' ' num2str(phonemeend*10^5) ' ' upper(Phonemes{prevphoneme}) '\n']);
                prevphoneme = currphoneme;
                phonemestart = phonemeend;
%             else
%                 phonemeend = 0;
                continue;
%             end
        end
    end
    fprintf(fid, '.\n');
    fclose(fid);

end

