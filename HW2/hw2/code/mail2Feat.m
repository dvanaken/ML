function [ Feats ] = mail2Feat( Mail )
    nMail = size(Mail,1);
    %Feats = ones(nMail,1); 

    % THE FOLLOWING IS A VERY SIMPLE EXAMPLE SHOWING ONE POSSIBLE WAY TO
    % COLLECT FEATURES. PLEASE REPLACE WITH YOUR CODE. NOTE HOW YOU CAN PLACE
    % PRE-PROCESSED RESULTS IN dictionary.csv.
    % NOTE: commented out for speed while testing previous exercises.

    % load data from dictionary.csv file
    fid = fopen('dictionary.csv');    
    tline = fgetl(fid);
    data = strread(tline,'%s','delimiter',',');
    
    %wordMap = containers.Map();
    mailWords = cell(nMail);
    for n=1:nMail
        thisMail = Mail{n};
        nWordCells = length(thisMail);
        words = [];
        wordIdx = 1;
        for i=1:nWordCells
            % Remove punctuation, digits, etc.
            C = regexp(thisMail{i}, '[^A-Za-z]', 'split');
            % Remove empty cells
            C=C(~cellfun('isempty',C));
            % Make everything lowercase
            C=lower(C);

            for j=1:length(C)
                word = C{j};
                % Word must have length of at least 3
                 if (length(word) > 2)
                     words{wordIdx} = word;
                     wordIdx = wordIdx + 1;
                 end
            end
        end
        words = unique(words);
        words = setdiff(words, data);
        mailWords{n} = words;
        if n==1
            masterWords = words;
            mailFeats = ones(1,length(masterWords));
        else
            for i=1:length(words)
                word = words{i};
                idx = find(strcmp(word,masterWords));
                if isempty(idx) % New word
                    masterWords = horzcat(masterWords,word);
                    mailFeats(n, length(masterWords)) = 1;
                else            % This word is already in masterWords
                    mailFeats(n,idx) = 1;
                end
            end
        end
    end
    
    % Chop off infrequent and very frequent words (10% threshold)
    lowerBound = nMail * .1;
    upperBound = nMail - lowerBound;
    mailFeats(:,sum(mailFeats) < lowerBound) = [];
    mailFeats(:,sum(mailFeats) > upperBound) = [];
    
    sums = sum(mailFeats);
    for i=1:size(mailFeats,2)
        prop = sums(:,i)/nMail;
        mailFeats(:,i) = mailFeats(:,i)*prop;
    end
Feats = mailFeats;
end

