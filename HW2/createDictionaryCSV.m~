function [ Feats ] = createDictionaryCSV( Mail1, Mail2 )
    Mail = vertcat(Mail1, Mail2);
    nMail = size(Mail,1);

    % THE FOLLOWING IS A VERY SIMPLE EXAMPLE SHOWING ONE POSSIBLE WAY TO
    % COLLECT FEATURES. PLEASE REPLACE WITH YOUR CODE. NOTE HOW YOU CAN PLACE
    % PRE-PROCESSED RESULTS IN dictionary.csv.
    % NOTE: commented out for speed while testing previous exercises.

    % load data from dictionary.csv file
    fid = fopen('stopwords.csv');
    tline = fgetl(fid);
    stopwords = strread(tline,'%s','delimiter',',');
    fclose(fid);
    wordMap = containers.Map();
    for n=1:nMail
        doc = Mail{n};
        nPhrases = length(doc);
        words = [];
        wordIdx = 1;
        for i=1:nPhrases
            % Remove punctuation, digits, etc.
             C = regexp(doc{i}, '[^A-Za-z]', 'split');
%             % Remove empty cells
             C=C(~cellfun('isempty',C));
%             % Make everything lowercase
             C=lower(C);
            for j=1:length(C)
                word = C{j};
                % Word must have length of at least 3
                 if (length(word) > 2)
                     if word(end) == 's'
                         word=word(1:end-1); 
                     end
                     words{wordIdx} = word;
                     wordIdx = wordIdx + 1;
                 end
            end
        end
        words = setdiff(words, stopwords);
        uniquewords = unique(words);
        for i=1:length(uniquewords)
             word = words{i};
             wordCount = sum(strcmp(words,word));
             if isKey(wordMap, word)
                 value = wordMap(word);
                 value = horzcat(value, [n,wordCount]);
                 wordMap(word) = value;
             else
                 wordMap(word) = [n,1];
             end
        end
    end
    % Chop off infrequent and very frequent words (10% threshold)
    lowerBound = nMail * .1;
    upperBound = nMail - lowerBound;
    keySet = keys(wordMap);
    finalWords = [];
    props = [];
    idx = 1;
    for i=1:length(keySet)
        word = keySet{i};
        prop = length(wordMap(word)) / 2;
        if prop < lowerBound || prop > upperBound
            remove(wordMap, word);
        else
            finalWords{idx} = word;
            props{idx} = log(nMail/(prop+1));
            idx = idx + 1;
        end
    end
    fid = fopen('dictionary.csv','wt');
    for i=1:length(finalWords)
       fprintf(fid,'%s,%f,',finalWords{i},props{i}); 
    end
    length(props)

    fclose(fid);
end

