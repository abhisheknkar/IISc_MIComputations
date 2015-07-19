function coreStorer( inputGood, inputGoodsizemat, fieldname )
%%This code contains the common subroutine to distribute the outputs into
%a file
    subjects = {'Abhay', 'Abhishek', 'Gopika', 'Niranjana'};
    load('Outputs/GoodSentences.mat');

    for i = 1:4
        disp(subjects{i});
        count = 0;
        for k = 1:length(GoodSentences{i})            
            clear 'finalstruct'
            outputfilename = ['Outputs/mats_final/' subjects{i} '/' num2str(GoodSentences{i}(k)) '.mat'];
            load(outputfilename);

            finalstruct.(fieldname) = inputGood{i}(count+1:count+inputGoodsizemat{i}(k), 1:size(inputGood{i},2));
            count = count + inputGoodsizemat{i}(k);
            
            save(outputfilename, 'finalstruct');
        end
    end
end

